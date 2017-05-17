//
//  NewsList.swift
//  NewsApi
//
//Copyright (c) 2017 Jaysukh. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON // to manage json responce


// struct of news data
public struct NewsList {
    let author: String
    let title: String
    let description: String
    let url: String
    let urlImage: String
}



//convert json object to struct format
extension NewsList: JSONConvertible {
    static func fromJSON(json: JSON) -> NewsList {
        //return data of each keyvalue of json
        return NewsList(author: json["author"].stringValue,
                        title: json["title"].stringValue,
                        description: json["description"].stringValue,
                        url: json["url"].stringValue,
                        urlImage: json["urlToImage"].stringValue)
    }
}
