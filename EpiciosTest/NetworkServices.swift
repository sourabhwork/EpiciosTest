//
//  NetworkServices.swift
//  EpiciosTest
//
//  Created by Sourabh Kumbhar on 19/12/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//


import Foundation

class NetworkServices {
    
    func fetchArticle(pageNo: Int = 1, completion: @escaping(_ success: Bool, _ message: String?, _ response: Array<Article>?)-> ()) {
        // Create url
        let urlString = ConstantURL.baseURL + ConstantKey.page + "=" + "\(pageNo)&" + ConstantKey.limit + "=" + "\(10)"
        guard let url = URL(string: urlString) else {
            completion(false, ConstantKey.urlNotValid, nil)
            return
        }        
        // Create url request
        var requst = URLRequest(url: url)
        
        // Set http method
        requst.httpMethod = "GET"
        
        // Create Session
        let session = URLSession.shared
        
        // Create datatask
        let dataTask = session.dataTask(with: requst, completionHandler: {
            (data, response, error)->Void in
            print("Data",data)
            print("Response", response)
            print("Error",error)
            if error != nil {
                completion(false, error?.localizedDescription, nil)
                return
            }
            if let convertData = data {
                do {
                    // Parsing data using codable and pass data to viewcontroller through completion
                    let responseDataArray = try JSONDecoder().decode([Article].self, from: convertData)
                    print(responseDataArray)
                    completion(true, nil, responseDataArray)
                    return
                } catch let error {
                    // Handle error
                    completion(false, error.localizedDescription, nil)
                    return
                }
            } else {
                completion(false, ConstantKey.somethingWentWrong, nil)
                return
            }
        }).resume()
    }
}
