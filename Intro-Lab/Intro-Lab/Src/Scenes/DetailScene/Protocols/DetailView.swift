

import UIKit

protocol DetailView {
    
    var imageView: ImageLoader { get set }
    var titleLabel: UILabel { get set }
    var subtitleLabel: UILabel { get set }
    var dateLabel: UILabel { get set }
    var authorLabel: UILabel { get set }
    var URLButton: UIButton { get set }
    
    func showAlert()
}
