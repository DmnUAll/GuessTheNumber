import UIKit

// MARK: - GuessController
final class GuessController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: GuessPresenter?
    lazy var guessView: GuessView = {
        let uiView = GuessView()
        return uiView
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        UIImageView.setAsBackground(withImage: "background", to: self)
        presenter = GuessPresenter(viewController: self)
        view.addSubview(guessView)
        setupConstraints()
        guessView.suggestionTextField.delegate = self
    }
}

// MARK: - Helpers
private extension GuessController {

    private func setupConstraints() {
        let constraints = [
            guessView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guessView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            guessView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            guessView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension GuessController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
}
