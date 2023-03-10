

import Foundation

protocol MainPresenter {
    
    func getNews()
    func loadMoreNews()
    func pullToRefresh()
    func onCellSelected(_ index: Int)
    func fixView(_ index: Int)
    func getData()
    func viewDidLoad()
    
    var articles: [Article] { get set }
    var dataModel: [DataModel] { get set }
    var newsEntity: NewsEntity? { get set }
}
