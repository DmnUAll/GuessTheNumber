import Foundation
import MediaPlayer

// MARK: - GuesPresenter
final class GuessPresenter {

    // MARK: - Properties and Initializers
    weak var viewController: GuessController?
    private var player: AVAudioPlayer?
    private var guessGame = GuessGameModel()

    init(viewController: GuessController? = nil) {
        self.viewController = viewController
        viewController?.guessView.delegate = self

        let tap = UITapGestureRecognizer(target: viewController?.view, action: #selector(UIView.endEditing))
        viewController?.view.addGestureRecognizer(tap)

        getNumbersDiapasone()
    }
}

// MARK: - Helpers
private extension GuessPresenter {

    private func playSound(_ soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        guard let playerWithAudio = try? AVAudioPlayer(contentsOf: url) else { return }
        player = playerWithAudio
        player?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self = self else { return }
            self.player?.stop()
            self.player = nil
        })
    }

    private func intCheckingErrorMessage() {
        let alertController = UIAlertController(
            title: "Hey!",
            message: "You should enter an Int value!",
            preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Got it!", style: .default, handler: nil)
        alertController.addAction(actionOK)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - GuessViewDelegate
extension GuessPresenter: GuessViewDelegate {

    func getNumbersDiapasone() {
        guard let sharedUI = viewController?.guessView else { return }
        guessGame.fromNumber = Int.random(in: -100...50)
        guessGame.toNumber = Int.random(in: (guessGame.fromNumber + 1)...100)
        sharedUI.chalkboardFromNumberLabel.text = String(guessGame.fromNumber)
        sharedUI.chalkboardToNumberLabel.text = String(guessGame.toNumber)
        playSound("chalkboard")
    }

    func checkUserGuess(forNumber number: String) {
        guard let sharedUI = viewController?.guessView else { return }
        guard let guess = Int(number) else {
            intCheckingErrorMessage()
            return
        }
        guessGame.userGuess = guess
        guessGame.actualSuggestion = Int.random(in: (guessGame.fromNumber...guessGame.toNumber))
        sharedUI.suggestedNumberLabel.text = String(guessGame.actualSuggestion)

        sharedUI.computerResultLabel.text = guessGame.compareAnswers()
        playSound("keyboard")
    }
}
