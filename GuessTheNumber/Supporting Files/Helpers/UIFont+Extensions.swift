import UIKit

extension UILabel {
    func addShadow(withColor color: UIColor) {
        self.shadowColor = color
        self.shadowOffset = CGSize(width: 0, height: -1)
    }
}
