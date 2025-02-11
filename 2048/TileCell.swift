import UIKit

class TileCell: UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.frame = contentView.bounds
        contentView.addSubview(label)
    }
    
    func configure(value: Int) {
        label.text = value == 0 ? "" : "\(value)"
        contentView.backgroundColor = switch value {
        case 2...4:
            .yellow
        case 8...16:
            .orange
        case 32...64:
            .red
        case 128...256:
            .brown
        case 512:
            .darkGray
        case 1024:
            .blue
        case 2048:
            .purple
        default:
            .lightGray
        }
    }
}
