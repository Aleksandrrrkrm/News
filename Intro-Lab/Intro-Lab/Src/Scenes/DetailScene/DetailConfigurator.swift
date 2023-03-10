//
//  DetailConfigurator.swift
//  Intro-Lab
//
//  Created by Александр Головин on 04.02.2023.
//

import UIKit

enum DetailConfigurator {
    
    static func configure(view: DetailViewController,
                          choseNews: Article?) {
        let router = DetailRouter(view)
        let presenter = DetailPresenterImp(view, router)
        view.presenter = presenter
        presenter.article = choseNews
    }

    static func open(navigationController: UINavigationController,
                     choseNews: Article?) {
        let view = DetailViewController()
        Self.configure(view: view,
                       choseNews: choseNews)
        navigationController.pushViewController(view, animated: true)
    }
}
