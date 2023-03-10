

import Foundation

protocol DetailPresenter {
    
    var article: Article? { get set }
    
    func viewDidLoad()
    func openWebView()
}
