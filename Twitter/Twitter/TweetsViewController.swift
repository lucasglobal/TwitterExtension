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
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                print(tweet.text!)
                self.tableView.reloadData()
            }
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

        cell.labelName.sizeToFit()
        cell.labelName.text = String(tweet.text!)
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





