//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Илья Валито on 18.09.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var suggestedNumberLabel: UILabel!
    @IBOutlet weak var guessField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    // Create a player to play osund.
    var player: AVAudioPlayer!
    // Play a specific sound from the Sounds folder.
    func playSound(titleLetter: String) {
        let url = Bundle.main.url(forResource: titleLetter, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    // Show the error message if there an error in textfield input.
    func intErrorMessage(){
        // Create the allert window.
        let alertController = UIAlertController(
            title: "Hey!",
            message: "You should enter an Int value!",
            preferredStyle: .alert
        )
        // Create the "Ok" button.
        let actionOK = UIAlertAction(title: "Got it!", style: .default, handler: nil)
        
        // Add buttons to the alert controller window.
        alertController.addAction(actionOK)
     
        // Show alert window.
        self.present(alertController, animated: true, completion: nil)
    }
    
    //  Generate the guessing numbers diapasone.
    func getDiapasone(){
        fromLabel.text = String(Int.random(in: -100...50))
        toLabel.text = String(Int.random(in: Int(fromLabel.text!)!+1...100))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the keyboard, when touched anywhere else.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        getDiapasone()
    }
    
    // Clear all labels when the guesss field are edited.
    @IBAction func guessFieldClearing(_ sender: UITextField) {
        resultLabel.text = ""
        suggestedNumberLabel.text = ""
        guessField.text = ""
    }
    
    // Hide the keyboard when return is pressed.
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // Refresh the guessing numbers diapasone.
    @IBAction func refreshButton(_ sender: UIButton) {
        resultLabel.text = ""
        suggestedNumberLabel.text = ""
        guessField.text = ""
        getDiapasone()
        playSound(titleLetter: "chalkboard")
    }
    
    @IBAction func guessButton(_ sender: UIButton) {
        
        guard let guess = Int(guessField.text!) else{
            intErrorMessage()
            return
        }
        
        suggestedNumberLabel.text = String(Int.random(in: Int(fromLabel.text!)!...Int(toLabel.text!)!))
        
        let guessGame = Guess(from: Int(fromLabel.text!)!, to: Int(toLabel.text!)!, guess: guess, suggestion: Int(suggestedNumberLabel.text!)!)
        
        resultLabel.text = guessGame.result()
        playSound(titleLetter: "keyboard")
    }
    
}

