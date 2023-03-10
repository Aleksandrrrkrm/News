

import UIKit

enum MainConfigurator {
    
    static func configure(view: MainViewController) {
        let router = MainRouter(view)
        let gateway = CacheTransactionGatewayImp(coreDataStack: CoreStack.shared)
        let presenter = MainPresenterImp(view, router, gateway)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        let view = MainViewController()
        Self.configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
