

import Foundation

protocol MainView {
    
    func startActivity()
    func stopActivity()
    func reloadTableData()
    func refreshEndRefreshing()
    func showAlert(_ title: String?, _ messege: String?)
}
