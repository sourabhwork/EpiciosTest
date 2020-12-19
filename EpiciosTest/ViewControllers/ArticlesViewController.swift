//
//  ArticlesViewController.swift
//  EpiciosTest
//
//  Created by Sourabh Kumbhar on 19/12/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var articleTableView : UITableView!
    var articlesViewModel               : ArticlesViewModel?
    private var activityIndicator       = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkServies = NetworkServices()
        articlesViewModel = ArticlesViewModel(networkServices: networkServies)
        setupUI()
        self.networkCall()
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
        setupActivityIndicator()
    }
    
    private func setupNavigationBar() {
        self.title = ConstantKey.articles
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Cabin-Bold", size: 24)]
    }
    
    private func setupTableView() {
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.tableFooterView = UIView()
        articleTableView.estimatedRowHeight = 400
        articleTableView.rowHeight = UITableView.automaticDimension
        articleTableView.separatorColor = .clear
    }
    
    private func setupActivityIndicator() {
        activityIndicator.style = .gray
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
    }
}

// MARK:- TableView Delegate and Datasource

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return articlesViewModel?.getArticlesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create object of ArticlesTableViewCell
        guard let articleTablViewCell = tableView.dequeueReusableCell(withIdentifier: TableCellConstant.articlesTableViewCell, for: indexPath) as? ArticlesTableViewCell else {
            return UITableViewCell()
        }
        // Assign data to cell
        if let article = articlesViewModel?.getArticle(index: indexPath.row) {
            articleTablViewCell.configureCell(article: article)
        }
        return articleTablViewCell
    }
    
}

extension ArticlesViewController {
    
    private func networkCall() {
        articlesViewModel?.callToNetworkServices(completion: {
            (isSuccess, message) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.articleTableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showAlert(title: ConstantKey.error, message: message ?? ConstantKey.somethingWentWrong)
                }
            }
        })
    }
}

// MARK:- ScrollView Delegate

extension ArticlesViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Validate condition for scroll inset to bottom table view
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if  maximumOffset - currentOffset <= 10.0{
            activityIndicator.startAnimating()
            self.networkCall()
        } else {
            activityIndicator.stopAnimating()
        }
        self.articleTableView.tableFooterView = activityIndicator
    }
}
