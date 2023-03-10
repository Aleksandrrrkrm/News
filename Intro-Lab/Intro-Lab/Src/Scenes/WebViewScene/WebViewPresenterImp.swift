//
//  WebViewPresenterImp.swift
//  Intro-Lab
//
//  Created by Александр Головин on 04.02.2023.
//

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
