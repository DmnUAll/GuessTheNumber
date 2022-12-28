import UIKit

// MARK: - GuessViewDelegate protocol
protocol GuessViewDelegate: AnyObject {
    func getNumbersDiapasone()
    func checkUserGuess(forNumber number: String)
}

// MARK: - GuessView
final class GuessView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: GuessViewDelegate?
    private lazy var chalkboardStackView: UIStackView = {
        let stackView = makeStackView(axis: .vertical,
                                      alignment: .fill,
                                      distribution: .fill)

        stackView.toAutolayout()
        stackView.addArrangedSubview(makeLabel(withText: """
What number range we will guess?
Press the chalkboard to update the numbers
""",
                                               sized: UIScreen.screenSize(heightDividedBy: 70),
                                               alignment: .center,
                                               fontName: "Chalkduster",
                                               andTextColor: .gtnWhite))
        return stackView
    }()

    private lazy var chalkboardButton: UIButton = {
        makeButton(withAction: #selector(chalkboardButtonTapped))
    }()

    private lazy var fromStackView: UIStackView = {
        let stackView = makeStackView(axis: .horizontal,
                                      alignment: .fill,
                                      distribution: .fill)

        stackView.addArrangedSubview(makeLabel(withText: "From:",
                                               sized: 16,
                                               alignment: .right,
                                               fontName: "Chalkduster",
                                               andTextColor: .gtnWhite))
        return stackView
    }()

    private lazy var toStackView: UIStackView = {
        let stackView = makeStackView(axis: .horizontal,
                                      alignment: .fill,
                                      distribution: .fill)

        stackView.addArrangedSubview(makeLabel(withText: "To:",
                                               sized: 16,
                                               alignment: .right,
                                               fontName: "Chalkduster",
                                               andTextColor: .gtnWhite))
        return stackView
    }()

    lazy var chalkboardFromNumberLabel: UILabel = {
        makeLabel(withText: "",
                  sized: 16,
                  alignment: .left,
                  fontName: "Chalkduster",
                  andTextColor: .gtnWhite)
    }()

    lazy var chalkboardToNumberLabel: UILabel = {
        makeLabel(withText: "",
                  sized: 16,
                  alignment: .left,
                  fontName: "Chalkduster",
                  andTextColor: .gtnWhite)
    }()

    lazy var suggestedNumberLabel: UILabel = {
        let label = makeLabel(withText: "",
                              sized: UIScreen.screenSize(heightDividedBy: 40),
                              alignment: .center,
                              fontName: "Marker Felt Thin",
                              andTextColor: .gtnYellow)
        label.addShadow(withColor: .gtnRed)
        label.toAutolayout()
        return label
    }()

    private lazy var computerStackView: UIStackView = {
        let stackView = makeStackView(
            axis: .vertical,
            alignment: .fill,
            distribution: .fill)

        stackView.toAutolayout()
        let label = makeLabel(
            withText: "Enter your guess and press the keyboard, meatbag:",
            sized: UIScreen.screenSize(heightDividedBy: 70),
            alignment: .center,
            fontName: "PingFang HK Thin",
            andTextColor: .gtnLight)

        label.addShadow(withColor: .gtnGreen)
        stackView.addArrangedSubview(label)
        return stackView
    }()

    let suggestionTextField: UITextField = {
        let textField = UITextField()
        textField.toAutolayout()
        textField.backgroundColor = .lightGray
        return textField
    }()

    lazy var computerResultLabel: UILabel = {
        let label = makeLabel(withText: "",
                              sized: UIScreen.screenSize(heightDividedBy: 70),
                              alignment: .left,
                              fontName: "PingFang HK Thin",
                              andTextColor: .gtnLight)
        label.addShadow(withColor: .gtnGreen)
        return label
    }()

    private lazy var keyboardButton: UIButton = {
        makeButton(withAction: #selector(keyboardButtonTapped))
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
private extension GuessView {

    @objc private func chalkboardButtonTapped() {
        computerResultLabel.text = ""
        suggestedNumberLabel.text = ""
        suggestionTextField.text = ""
        delegate?.getNumbersDiapasone()
    }

    @objc private func keyboardButtonTapped() {
        delegate?.checkUserGuess(forNumber: suggestionTextField.text ?? "")
    }

    private func addSubviews() {
        fromStackView.addArrangedSubview(chalkboardFromNumberLabel)
        toStackView.addArrangedSubview(chalkboardToNumberLabel)
        chalkboardStackView.addArrangedSubview(fromStackView)
        chalkboardStackView.addArrangedSubview(toStackView)
        computerStackView.addArrangedSubview(suggestionTextField)
        computerStackView.addArrangedSubview(computerResultLabel)
        addSubview(chalkboardStackView)
        addSubview(chalkboardButton)
        addSubview(suggestedNumberLabel)
        addSubview(computerStackView)
        addSubview(keyboardButton)
    }

    private func setupConstraints() {
        let constraints = [
            chalkboardStackView.widthAnchor.constraint(equalToConstant: UIScreen.screenSize(heightDividedBy: 5) + 5),
            chalkboardStackView.heightAnchor.constraint(equalToConstant: UIScreen.screenSize(heightDividedBy: 6) - 15),
            chalkboardStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                         constant: UIScreen.screenSize(heightDividedBy: 11)),
            chalkboardStackView.topAnchor.constraint(equalTo: topAnchor,
                                                     constant: UIScreen.screenSize(heightDividedBy: 140)),
            chalkboardButton.topAnchor.constraint(equalTo: chalkboardStackView.topAnchor),
            chalkboardButton.leadingAnchor.constraint(equalTo: chalkboardStackView.leadingAnchor),
            chalkboardButton.trailingAnchor.constraint(equalTo: chalkboardStackView.trailingAnchor),
            chalkboardButton.bottomAnchor.constraint(equalTo: chalkboardStackView.bottomAnchor),
            suggestedNumberLabel.widthAnchor.constraint(equalToConstant: UIScreen.screenSize(heightDividedBy: 20)),
            suggestedNumberLabel.leadingAnchor.constraint(equalTo: chalkboardStackView.trailingAnchor,
                                                          constant: UIScreen.screenSize(heightDividedBy: 17.3)),
            suggestedNumberLabel.centerYAnchor.constraint(equalTo: chalkboardStackView.centerYAnchor,
                                                          constant: UIScreen.screenSize(heightDividedBy: 40)),
            computerStackView.widthAnchor.constraint(equalToConstant: UIScreen.screenSize(heightDividedBy: 4.5)),
            computerStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                       constant: UIScreen.screenSize(heightDividedBy: 7.5)),
            computerStackView.topAnchor.constraint(equalTo: topAnchor,
                                                   constant: UIScreen.screenSize(heightDividedBy: 2.7)),
            keyboardButton.widthAnchor.constraint(equalToConstant: UIScreen.screenSize(heightDividedBy: 2.7)),
            keyboardButton.heightAnchor.constraint(equalToConstant: UIScreen.screenSize(heightDividedBy: 10)),
            keyboardButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: UIScreen.screenSize(heightDividedBy: 17)),
            keyboardButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                   constant: -UIScreen.screenSize(heightDividedBy: 60))
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeStackView(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment,
                               distribution: UIStackView.Distribution, withSpacing spacing: CGFloat = 0
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.backgroundColor = .clear
        stackView.spacing = spacing
        return stackView
    }

    private func makeLabel(withText text: String, sized size: CGFloat, alignment: NSTextAlignment,
                           fontName: String, andTextColor color: UIColor) -> UILabel {
        let label = UILabel()
        label.font =  UIFont(name: fontName, size: size)
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.textColor = color
        label.text = text
        return label
    }

    private func makeButton(withAction action: Selector) -> UIButton {
        let button = UIButton()
        button.toAutolayout()
        button.backgroundColor = .clear
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}
