//
//  DetailPresenter.swift
//  Intro-Lab
//
//  Created by Александр Головин on 04.02.2023.
//


import Foundation

protocol DetailPresenter {
    
    var article: Article? { get set }
    
    func viewDidLoad()
    func openWebView()
}
