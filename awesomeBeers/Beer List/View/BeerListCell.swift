import Kingfisher
import UIKit

class BeerListCell: UICollectionViewCell {
    
    static var identifier = "BeerListCell"
    
    weak var nameLabel: UILabel!
    weak var imageView: UIImageView!
    weak var abvLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        accessibilityIdentifier = "BeerListCell"
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        
        backgroundColor = .white
        layer.cornerRadius = 10.0
        
        let imageView = UIImageView()
        
        let nameLabel = UILabel(frame: .zero)
        
        let abvLabel = UILabel(frame: .zero)
        
        [imageView, nameLabel, abvLabel].forEach { self.contentView.addSubview($0) }
        
        let topLineLayer = CALayer()
        topLineLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        topLineLayer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nameLabel.layer.addSublayer(topLineLayer)
        
        self.nameLabel = nameLabel
        self.nameLabel.textAlignment = .center
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.nameLabel.lineBreakMode = .byWordWrapping
        self.nameLabel.numberOfLines = 0
        self.nameLabel.sizeToFit()
        
        self.imageView = imageView
        self.imageView.contentMode = .scaleAspectFit
        
        self.abvLabel = abvLabel
        self.abvLabel.textColor = .white
        self.abvLabel.backgroundColor = .black
        self.abvLabel.textAlignment = .center
        self.abvLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.abvLabel.sizeToFit()
    }
    
    private func setupContraints() {
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nameLabel.topAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 8, right: 10))
        
        nameLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        
        abvLabel.anchor(top: nameLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    func show(beer: Beer) {
        nameLabel.text = beer.name
        abvLabel.text = "abv: \(beer.abv)"
        
        let imageURL = URL(string: beer.imageUrl)

        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeholder"))

        imageView.kf.setImage(
            with: imageURL,
            placeholder: #imageLiteral(resourceName: "placeholder"),
            options: nil,
            completionHandler: {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            })
    }
}
