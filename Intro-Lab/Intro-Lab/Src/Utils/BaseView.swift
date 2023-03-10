//
//  BaseView.swift
//  Intro-Lab
//
//  Created by Александр Головин on 05.02.2023.
//

import UIKit

class BaseView: UIViewController {
    
    func showErrorDialog( _ title: String?, _ messege: String?) {
            let alertVC = UIAlertController(
                title: title,
                message: messege,
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
}
