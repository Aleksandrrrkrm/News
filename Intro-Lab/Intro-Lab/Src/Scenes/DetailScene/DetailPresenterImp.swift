

import UIKit

final class DetailPresenterImp: DetailPresenter {
    
    private var view: DetailView?
    private let router: DetailRouter
    var article: Article?
    
    init(_ view: DetailView,
         _ router: DetailRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
        setupViews()
    }
    
    private func setupViews() {
        setupTitleLabel()
        setupImageView()
        setupSubTitle()
        setupDate()
        setupAuthor()
        setupURLLabel()
    }
    
    private func setupTitleLabel() {
        self.view?.titleLabel.text = article?.title
    }
    
    private func setupImageView() {
        if let url = article?.urlToImage {
            self.view?.imageView.loadImageWithUrl(url)
        } else {
            self.view?.imageView.image = UIImage(named: "placeholder")
        }
    }
    
    private func setupSubTitle() {
        self.view?.subtitleLabel.text = article?.description
    }
    
    private func setupDate() {
        guard let date = article?.publishedAt else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        self.view?.dateLabel.text = dateFormatter.string(from: date)
    }
    
    private func setupAuthor() {
        guard let author = article?.author else {
            self.view?.authorLabel.text = "Автор неизвестен"
            return
        }
        self.view?.authorLabel.text = author
    }
    
    func openWebView() {
        guard let url = article?.url else {
            view?.showAlert()
            return
        }
        router.openWebViewScene(url)
    }
    
    private func setupURLLabel() {
        guard let url = article?.url else {
            return
        }
        view?.URLButton.setTitle(url.absoluteString, for: .normal)
    }
}
