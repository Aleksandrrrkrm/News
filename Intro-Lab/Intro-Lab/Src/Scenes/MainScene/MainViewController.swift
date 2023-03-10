//
//  MainViewController.swift
//  Intro-Lab
//
//  Created by Александр Головин on 03.02.2023.
//

import UIKit

final class MainViewController: BaseView {
    
    // MARK: - Properties
    internal var presenter: MainPresenter?
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    let activity = UIActivityIndicatorView()
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainConfigurator.configure(view: self)
        configureView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Новости"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    // MARK: - Configure View
    private func configureView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(onPullRefresh), for: .valueChanged)
        
        activity.color = .darkGray
        tableView.backgroundView = activity
        stopActivity()
        configureTableView()
    }
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.addSubview(refreshControl)
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Usage
    @objc
    func onPullRefresh() {
            presenter?.pullToRefresh()
        }
    
    func refreshEndRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func getNews() {
        startActivity()
        self.presenter?.getNews()
    }
    
    func reloadTableData() {
        tableView.reloadData()
    }
}

extension MainViewController: MainView {
    
    func startActivity() {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func stopActivity() {
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    func showAlert(_ title: String?, _ messege: String?) {
        self.showErrorDialog(title, messege)
    }
}

// MARK: - Table View Data Source
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        guard let articles = presenter?.articles[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setupCell(articles)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = presenter?.articles.count,
              let totalCount = presenter?.newsEntity?.totalResults else {
            return
        }
        if indexPath.row == count - 1 && count < totalCount {
            presenter?.loadMoreNews()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onCellSelected(indexPath.row)
        presenter?.fixView(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}


