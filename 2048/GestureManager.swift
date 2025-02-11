import UIKit

protocol GestureDelegate: AnyObject {
    func didSwipe(_ direction: UISwipeGestureRecognizer.Direction)
}

class GestureManager {
    weak var delegate: GestureDelegate?

    func addSwipeGestures(to view: UIView) {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            gesture.direction = direction
            view.addGestureRecognizer(gesture)
        }
    }

    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        delegate?.didSwipe(gesture.direction)
    }
}
