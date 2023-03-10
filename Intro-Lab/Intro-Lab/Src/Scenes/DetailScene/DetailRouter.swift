//
//  DetailRouter.swift
//  Intro-Lab
//
//  Created by Александр Головин on 04.02.2023.
//

import UIKit

final class DetailRouter {
    
    weak var view: UIViewController?
    
    init(_ view: DetailViewController) {
        self.view = view
    }
    
    func openWebViewScene(_ url: URL) {
        guard let navController = self.view?.navigationController else {
            return
        }
        WebViewConfigurator.open(navigationController: navController, url)
    }
}
