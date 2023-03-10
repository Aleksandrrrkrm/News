

import Foundation

final class WebViewPresenterImp: WebViewPresenter {
    
    private var view: WebViewView?
    private let router: WebViewRouter
    var url: URL?
    
    init(_ view: WebViewView,
         _ router: WebViewRouter) {
        self.view = view
        self.router = router
    }
    
}
