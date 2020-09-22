import Kingfisher
import UIKit

class DetailView: UIView {
    
    var imageView: UIImageView
    let descriptionLabel: UITextView
    let taglineLabel: UILabel
    let abvLabel: UILabel
    let ibuLabel: UILabel
    let topLineLayer: CALayer
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        descriptionLabel = UITextView()
        taglineLabel = UILabel()
        abvLabel = UILabel()
        ibuLabel = UILabel()
        topLineLayer = CALayer()
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        self.initViews()
    }
    
    private func initViews() {
        [imageView, descriptionLabel, taglineLabel, abvLabel, ibuLabel].forEach {
            self.addSubview($0)
        }
        
        setupView()
        setupConstraints()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        topLineLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.accessibilityIdentifier = "BeerDetailView"
        self.taglineLabel.textAlignment = .center
        self.taglineLabel.textColor = .white
        self.taglineLabel.lineBreakMode = .byWordWrapping
        self.taglineLabel.numberOfLines = 0
        self.taglineLabel.sizeToFit()
        self.taglineLabel.backgroundColor = .black
        self.taglineLabel.layer.cornerRadius = 4
        self.taglineLabel.layer.masksToBounds = true
        
        self.imageView.contentMode = .scaleAspectFit
        
        topLineLayer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.descriptionLabel.layer.addSublayer(topLineLayer)
        
        self.descriptionLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        self.descriptionLabel.sizeToFit()
        
        abvLabel.font = UIFont.boldSystemFont(ofSize: 16)
        ibuLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupConstraints() {
        taglineLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        
        abvLabel.anchor(top: nil, leading: imageView.trailingAnchor, bottom: ibuLabel.topAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 8))
        
        ibuLabel.anchor(top: nil, leading: imageView.trailingAnchor, bottom: imageView.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 8))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.anchor(top: taglineLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 0))
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        descriptionLabel.anchor(top: imageView.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 32, left: 16, bottom: 8, right: 16))
    }
    
    func show(viewModel: BeerDetailViewModel) {
        imageView.kf.setImage(with: URL(string: viewModel.getBeer().imageUrl))
        descriptionLabel.text = viewModel.getBeer().description
        taglineLabel.text = viewModel.getBeer().tagline
        abvLabel.text = "abv: \(viewModel.getBeer().abv)"
        guard let ibu = viewModel.getBeer().ibu else { return }
        ibuLabel.text = "ibu: \(ibu)"
    }
    
}
