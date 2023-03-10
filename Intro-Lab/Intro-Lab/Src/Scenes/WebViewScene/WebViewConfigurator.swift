//
//  WebViewConfigurator.swift
//  Intro-Lab
//
//  Created by Александр Головин on 04.02.2023.
//

import UIKit

enum WebViewConfigurator {
    
    static func configure(view: WebViewViewController,
                          _ url: URL) {
        let router = WebViewRouter(view)
        let presenter = WebViewPresenterImp(view, router)
        view.presenter = presenter
        presenter.url = url
    }

    static func open(navigationController: UINavigationController,
                     _ url: URL) {
        let view = WebViewViewController()
        Self.configure(view: view,
                       url)
        navigationController.present(view, animated: true)
    }
}
