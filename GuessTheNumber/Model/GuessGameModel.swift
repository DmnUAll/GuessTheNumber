import Foundation

struct GuessGameModel {
    var fromNumber: Int = 0
    var toNumber: Int = 0
    var userGuess: Int = 0
    var actualSuggestion: Int = 0

    func compareAnswers() -> String {

        let aiGuess: Int = Int.random(in: fromNumber...toNumber)

        func createInfoMessage(withLastLine lastLine: String) -> String {

            return """
            The Magic Ball says: \(actualSuggestion)
            Your guess: \(userGuess)
            The Mighty PC guess: \(aiGuess)
            \(lastLine)
            """
        }

        if abs(actualSuggestion - userGuess) < abs(actualSuggestion - aiGuess) {
            return createInfoMessage(withLastLine: "Damn! You won!\nYou were closer to the number!")
        } else if abs(actualSuggestion - userGuess) == abs(actualSuggestion - aiGuess) {
            return createInfoMessage(withLastLine: "Oh no! A draw!\nWe're equally close to the number!")
        } else {
            return createInfoMessage(withLastLine: "Aha! I Won!\nI were closer to the number!")
        }
    }
}
