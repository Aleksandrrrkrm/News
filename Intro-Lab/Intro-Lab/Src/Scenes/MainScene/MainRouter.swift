//
//  MainRouter.swift
//  Intro-Lab
//
//  Created by Александр Головин on 03.02.2023.
//

import UIKit

final class MainRouter {
    
    weak var view: UIViewController?
    
    init(_ view: MainViewController) {
        self.view = view
    }
    
    func openDetailScene(_ currentNews: Article?) {
        guard let navController = self.view?.navigationController else {
            return
        }
        DetailConfigurator.open(navigationController: navController, choseNews: currentNews)
    }
}
