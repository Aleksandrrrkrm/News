

import UIKit

final class WebViewRouter {
    
    weak var view: UIViewController?
    
    init(_ view: WebViewViewController) {
        self.view = view
    }
    
    func openSomeScene() {
        guard let navController = self.view?.navigationController else {
            return
        }
        //  SomeSceneConfigurator.open(navigationController: navController)
    }
}
