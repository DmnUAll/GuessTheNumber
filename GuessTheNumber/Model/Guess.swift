//
//  Guess.swift
//  GuessTheNumber
//
//  Created by Илья Валито on 18.09.2021.
//

import Foundation

struct Guess{
    let from: Int
    let to: Int
    let guess: Int
    let suggestion: Int
    
    init(from: Int, to: Int, guess: Int, suggestion: Int) {
        self.from = from
        self.to = to
        self.guess = guess
        self.suggestion = suggestion
    }
    
    func result() -> String{
        let compGuess: Int = Int.random(in: from...to)
       
        if abs(suggestion - guess) < abs(suggestion - compGuess){
            return "The Magic Ball says: \(suggestion)\nYour guess: \(guess)\nThe Mighty PC guess: \(compGuess)\nDamn! You won!\nYou were closer to the number!"
        } else if abs(suggestion - guess) == abs(suggestion - compGuess) {
            return "The Magic Ball says: \(suggestion)\nYour guess: \(guess)\nThe Mighty PC guess: \(compGuess)\nOh no! A draw!\nWe're equally close to the number!"
        } else {
            return "The Magic Ball says: \(suggestion)\nYour guess: \(guess)\nThe Mighty PC guess: \(compGuess)\nAha! I Won!\nI were closer to the number!"
        }
    }
}
