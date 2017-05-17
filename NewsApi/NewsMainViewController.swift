//
//  NewsMainViewController.swift
//  NewsApi
// Copyright (c) 2017 Jaysukh. All rights reserved.

import UIKit
import SVProgressHUD
import SDWebImage
class NewsMainViewController: UIViewController {
//outlet 
    @IBOutlet weak var tableViewObject: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // call news api from manager
        NewsListManager.sharedInstance.retrieveNewsApi { (error) in
            guard let error = error else {
                //load tableview after getting responce
                self.tableViewObject.reloadData()
                debugPrint(NewsDBManager.getInstance().getAllNewsData().count)
                return
            }
            debugPrint(error)
        }
        
    }

}

extension NewsMainViewController: UITableViewDelegate {
    // this one is estimated height of tableview
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 314.0 // set estimate tableview height
    }
    
    // this one used to set height text and other content wise
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension // this will auto adjust height of tableview based on all label content height
    }
}

extension NewsMainViewController: UITableViewDataSource {
    // determine number of row per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsDBManager.getInstance().getAllNewsData().count
    }
    
    // initialize each cell to tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsApiTableViewCell", for: indexPath) as! NewsApiTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        // get object of news list from manager
        let newsListObject = NewsDBManager.getInstance().getAllNewsData()[indexPath.row] as! NewsList
        //set image from url using sdwebimage library
        cell.newsImage.sd_setImage(with: URL(string: newsListObject.urlImage), placeholderImage: nil)
        cell.TitleLabel.text = "Title: \(newsListObject.title)"
        cell.AuthorLabel.text = "Author: \(newsListObject.author)"
        cell.DescriptionLabel.text = "Description: \(newsListObject.description)"
        cell.URLLabel.text = "News URL: \(newsListObject.url)"
        return cell
    }
    
}
