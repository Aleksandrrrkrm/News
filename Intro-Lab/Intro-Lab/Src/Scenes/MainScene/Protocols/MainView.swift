//
//  MainView.swift
//  Intro-Lab
//
//  Created by Александр Головин on 03.02.2023.
//

import Foundation

protocol MainView {
    
    func startActivity()
    func stopActivity()
    func reloadTableData()
    func refreshEndRefreshing()
    func showAlert(_ title: String?, _ messege: String?)
}
