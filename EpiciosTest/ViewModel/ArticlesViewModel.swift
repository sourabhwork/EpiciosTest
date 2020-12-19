//
//  ArticlesViewModel.swift
//  EpiciosTest
//
//  Created by Sourabh Kumbhar on 19/12/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation


class ArticlesViewModel {
    
    private static var pageNumber = 0
    private var articleArray = Array<Article>()
    var currentNetworkServices: NetworkServices?
    
    
    init(networkServices: NetworkServices) {
        self.currentNetworkServices = networkServices        
    }
    
    func callToNetworkServices(completion: @escaping(_ success: Bool, _ message: String?)->()) {
        ArticlesViewModel.pageNumber = ArticlesViewModel.pageNumber + 1
        currentNetworkServices?.fetchArticle(pageNo: ArticlesViewModel.pageNumber, completion: {
            (isSuccess, message, articles) in
            if let articles = articles {                
                self.articleArray.append(contentsOf: articles)
            }
            completion(isSuccess, message)
        })
    }
    
    func getArticlesCount()->Int {        
        return self.articleArray.count
    }
    
    func getArticle(index: Int)->Article? {
        if index < articleArray.count {
            return articleArray[index]
        }
        return nil 
    }
}

