//
//  NewsListManager.swift
//  NewsApi
//
//Copyright (c) 2017 Jaysukh. All rights reserved.


import UIKit
import SwiftyJSON

//completion handler -> used to after completion of request
typealias RetrieveAllNewsCompletion = (_ error: Error?) -> Void

class NewsListManager: NSObject {
    //shared instance to call this singleton class anywhere into app
    static let sharedInstance = NewsListManager()
    
    //variable of news array
    var newsListArray = [NewsList]()
    
    
    //call api of news
    func retrieveNewsApi(completion: @escaping RetrieveAllNewsCompletion) {
        ServiceCustom.sharedMyManager.GetAtURL(strURL: "https://newsapi.org/v1/articles?source=hacker-news&sortBy=top&apiKey=1cce33bfa01e4310991eff6c9a7f590d", sucess: { (operation, responce) in
            debugPrint(responce)
            let json = JSON(responce) //convert responce to json format using Swifty json
            
            
            //check responce status is "ok"
            if json["status"].stringValue == "ok" {
                let articleData = json["articles"]
                
                _ = NewsDBManager.getInstance().deleteNewsDB() // delete old data from database
                if articleData != JSON.null {
                    //convert json array to struct array
                    if let articleArray = articleData.array {
                        self.newsListArray = articleArray.map { return NewsList.fromJSON(json: $0) }
                    }
                    
                    // initialize and insert new data into datase from api responce
                    for newslist in self.newsListArray {
                        // insert each data from api responce
                        _ = NewsDBManager.getInstance().insertNewsToDB(newsList: newslist)
                    }
                    completion(nil) // call completion handler after getting responce
                }
            }
        }) { (operation, error) in
            debugPrint(error)
            completion(error) //pass error to completion handler
        }
    }

}
