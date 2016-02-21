//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/20/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var tweets: [Tweet]!

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0, green: 0, blue: 0.8, alpha: 0.3)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()

            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! CustomTableViewCell
        let tweet = tweets[indexPath.row]
        
        cell.tweet = tweet
        
        //tweet labels
        cell.tweetText.text = String(tweet.text!)
        cell.tweetText.sizeToFit()
        cell.tweetText.numberOfLines = 0
        cell.labelDate.text = String(tweet.timeStamp!)
        cell.labelFavoriteNumber.text = String(tweet.favoritesCount)
        cell.labelRetweetNumber.text = String(tweet.retweetCount)
            
        //user labels
        cell.labelUserName.text = tweet.userName
        cell.labelUserHandle.text = "@\(tweet.userHandle!)"
        
        //user profile picture
        cell.imageProfilePicture.setImageWithURL(tweet.imageProfileURL!)
        cell.imageProfilePicture.layer.cornerRadius = 28
        cell.imageProfilePicture.clipsToBounds = true
        
        
    

        
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets{
            return tweets.count
        }
        else{
            return 0
        }
    }
}





