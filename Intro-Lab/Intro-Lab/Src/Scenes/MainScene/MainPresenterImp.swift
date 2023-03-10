

import Foundation
import CoreData

final class MainPresenterImp: MainPresenter {
    
    private let cacheGateway: CacheNewsGateway

    private var view: MainView?
    private let router: MainRouter
    private var currentPage = 1
    internal var articles = [Article]()
    var newsEntity: NewsEntity?
    var dataModel = [DataModel]()
    var model = [DataModel]()
    let userDefaults = UserDefaults.standard
    var isConnection = true
    
    
    init(_ view: MainView,
         _ router: MainRouter,
         _ gateway: CacheNewsGateway) {
        self.view = view
        self.router = router
        self.cacheGateway = gateway
    }
    
    func viewDidLoad() {
        getData()
        view?.startActivity()
        getNews()
    }
    
    func getData() {
        let sortDes = NSSortDescriptor(key: #keyPath(DataArticle.publishedAt), ascending: false)
        if let cash = cacheGateway.getNews(predicate: nil, sortDescriptors: [sortDes]) {
            cash.forEach {
                self.articles.append(Article(title: $0.mainTitle ?? "News",
                                              description: $0.descriptionTitle,
                                              url: nil,
                                              urlToImage: nil,
                                              publishedAt: $0.publishedAt ?? Date(),
                                              author: nil))
            }
        }
        self.view?.reloadTableData()
    }
    
    func getNews() {
        NewsNetworkManager.shared.getArticles(currentPage: "\(currentPage)") { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self.isConnection = true
                    if self.currentPage == 1 {
                        self.articles = []
                    }
                    articles.articles.forEach {
                        self.articles.append($0)
                    }
                    self.newsEntity = articles
                    self.view?.reloadTableData()
                    self.view?.stopActivity()
                    self.view?.refreshEndRefreshing()
                    for model in self.articles {
                        let newData = DataModel(descriptionTitle: model.description ?? "Подробности на сайте",
                                                mainTitle: model.title,
                                                publishedAt: model.publishedAt)
                        self.model.append(newData)
                    }
                    self.dataModel = []
                    if self.currentPage == 1 {
                        self.cacheGateway.deleteAllNews()
                    }
                    self.cacheGateway.saveNews(self.model, completion: nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isConnection = false
                    self.view?.showAlert("Что-то пошло не так...", "Проверьте интернет соединение")
                    self.view?.stopActivity()
                    self.view?.refreshEndRefreshing()
                    self.view?.reloadTableData()
                }
#if DEBUG
                print(error)
#endif
            }
        }
    }
    
    func fixView(_ index: Int) {
        
        let article = articles[index]
        if let count = userDefaults.value(forKey: article.title) as? Int {
            var newCount = count
            newCount += 1
            userDefaults.set(newCount, forKey: article.title)
        } else {
            userDefaults.set(1, forKey: article.title)
        }
    }
    
    func pullToRefresh() {
        if isConnection {
            articles = []
        }
        self.newsEntity = nil
        self.view?.reloadTableData()
        currentPage = 1
        getNews()
    }
    
    func loadMoreNews() {
        currentPage += 1
        getNews()
    }
    
    func onCellSelected(_ index: Int) {
        let currentNews = articles[index]
        router.openDetailScene(currentNews)
    }
}
