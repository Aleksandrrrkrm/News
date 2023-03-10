

import UIKit

class MainTableViewCell: UITableViewCell {
    
    let userDefaults = UserDefaults.standard
    
    lazy var titleView: UILabel = {
       let thetitleView = UILabel()
        thetitleView.translatesAutoresizingMaskIntoConstraints = false
       return thetitleView
    }()
    
    lazy var image: ImageLoader = {
        let theImageView = ImageLoader()
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.contentMode = .scaleAspectFill
        return theImageView
    }()
    
    lazy var countImage: UIImageView = {
        let countImage = UIImageView()
        countImage.image = UIImage(named: "eye")
        countImage.translatesAutoresizingMaskIntoConstraints = false
        return countImage
    }()
    
    lazy var countView: UILabel = {
        let theTextView = UILabel()
        theTextView.font = UIFont(name: "arial", size: 10)
        theTextView.text = "0"
        theTextView.translatesAutoresizingMaskIntoConstraints = false
        return theTextView
    }()
    
    var currentNew: Article?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addViews()
        configureLayout()
    }
    
    func addViews() {
        
        contentView.addSubview(titleView)
        contentView.addSubview(image)
        contentView.addSubview(countView)
        contentView.addSubview(countImage)
    }
    
    func configureLayout() {

        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        titleView.numberOfLines = 0
        titleView.font = UIFont(name: "arial", size: 17)
        
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        image.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3).isActive = true
        
        titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        titleView.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 4).isActive = true
        titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        titleView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2).isActive = true
        
        countView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        countView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
        countImage.centerYAnchor.constraint(equalTo: countView.centerYAnchor).isActive = true
        countImage.rightAnchor.constraint(equalTo: countView.leftAnchor, constant: -2).isActive = true
        countImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        countImage.widthAnchor.constraint(equalToConstant: 9).isActive = true
    }
    
    func setupCell(_ chooseNew: Article) {
        
        if let url = chooseNew.urlToImage {
            DispatchQueue.main.async {
                self.image.loadImageWithUrl(url)
            }
        } else {
            image.image = UIImage(named: "placeholder")
        }
        titleView.text = chooseNew.title
        if let count = userDefaults.value(forKey: chooseNew.title) as? Int {
            countView.text = String(count)
        } 
    }
}
