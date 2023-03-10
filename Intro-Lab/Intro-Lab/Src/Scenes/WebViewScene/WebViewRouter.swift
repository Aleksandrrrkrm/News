//
//  WebViewRouter.swift
//  Intro-Lab
//
//  Created by Александр Головин on 04.02.2023.
//

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
