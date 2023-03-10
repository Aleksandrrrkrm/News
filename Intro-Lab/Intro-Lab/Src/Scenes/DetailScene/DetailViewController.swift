//
//  DetailViewController.swift
//  Intro-Lab
//
//  Created by Александр Головин on 04.02.2023.
//
import UIKit

final class DetailViewController: BaseView {
    
    // MARK: - Properties
    internal var presenter: DetailPresenter?
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var imageView: ImageLoader = {
        let theImageView = ImageLoader()
        theImageView.layer.cornerRadius = 5
        theImageView.clipsToBounds = true
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.contentMode = .scaleAspectFill
        return theImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont(name: "arial", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.sizeToFit()
        dateLabel.font = UIFont(name: "arial", size: 12)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.sizeToFit()
        authorLabel.font = UIFont(name: "arial", size: 12)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        return authorLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont(name: "arial", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var URLButton: UIButton = {
        let URLButton = UIButton(type: .system)
        URLButton.setTitle("Ссылка на источник", for: .normal)
        URLButton.backgroundColor = .clear
        URLButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        URLButton.translatesAutoresizingMaskIntoConstraints = false
        URLButton.setTitleColor(.blue, for: .normal)
        return URLButton
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Configure View
    private func setupView() {
        configureNavController()
        configureScrollAndContentViews()
        configureViews()
    }
    
    private func configureNavController() {
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
    }
    
    private func configureScrollAndContentViews() {
        
        view.backgroundColor = UIColor(named: "appMain")
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func configureViews() {
        
        // Title Label
        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -12).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Date Label
        contentView.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        // Author Label
        contentView.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        // Image View
        contentView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -12).isActive = true
        
        // Description Label
        contentView.addSubview(subtitleLabel)
        subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -12).isActive = true
        
        // Url Button
        contentView.addSubview(URLButton)
        URLButton.leftAnchor.constraint(equalTo: subtitleLabel.leftAnchor).isActive = true
        URLButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        URLButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    // MARK: - Usage
    @objc
    func buttonTap() {
        presenter?.openWebView()
    }
}
    

extension DetailViewController: DetailView {
    
    func showAlert() {
        self.showErrorDialog("Упс, что-то пошло не так...", "Проверьте интернет соединение")
    }
}
