//
//  NewsDBManager.swift
//  NewsApi
//Copyright (c) 2017 Jaysukh. All rights reserved.
//

import UIKit

let sharedInstance = NewsDBManager()
class NewsDBManager: NSObject {    
    var database: FMDatabase? = nil
    
    
    // this methos get path of database
    class func getInstance() -> NewsDBManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath(fileName: "newsdb.sqlite"))
        }
        return sharedInstance
    }
    
    
    //insert query of database. you can insert data of news from this method
    func insertNewsToDB(newsList: NewsList) -> Bool
    {
        sharedInstance.database!.open()
        
        // insert record query
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO newstable (author, title, description, url, urlimage) VALUES (?, ?, ?, ?, ?)", withArgumentsIn: [newsList.author, newsList.title, newsList.description, newsList.url, newsList.urlImage])
        sharedInstance.database!.close()
        return isInserted
    }
    
    
    // get all data from db of news. you can call this methods to get all data of news
    func getAllNewsData() -> NSMutableArray {
        sharedInstance.database!.open() //for open database
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM newstable", withArgumentsIn: nil) // get all result from db
        let muarrNewstable : NSMutableArray = NSMutableArray()
        if (resultSet != nil) { // fetch each result from db
            while resultSet.next()
            {
                muarrNewstable.add(NewsList(author: resultSet.string(forColumn: "author"), title: resultSet.string(forColumn: "title"), description: resultSet.string(forColumn: "description"), url: resultSet.string(forColumn: "url"), urlImage: resultSet.string(forColumn: "urlimage")))
            }
        }
        sharedInstance.database!.close() // for close database
        return muarrNewstable
    }
    
    
    //this methds used to delete all news data.
    func deleteNewsDB() -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM newstable", withArgumentsIn:nil) // sqlite query to delete db record
        sharedInstance.database!.close()
        return isDeleted
    }


}
