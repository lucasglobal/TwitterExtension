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

        //fetching data
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()

            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
        NSNotificationCenter.defaultCenter().addObserverForName("ProfileTouch", object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            let storyboard =  UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewControllerWithIdentifier("ProfileVC") as! ProfileViewController
            self.navigationController?.pushViewController(profileVC, animated: true)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! CustomTableViewCell
        let tweet = tweets[indexPath.row]
        tweet.positionInArray = indexPath.row
        cell.tweet = tweet
        
        //tweet labels
        cell.tweetText.text = String(tweet.text!)
        cell.tweetText.sizeToFit()
        cell.tweetText.numberOfLines = 0
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = .MediumStyle
        let dateToPrint: NSString = dateFormatter.stringFromDate(tweet.timeStamp!) as NSString
        
        cell.labelDate.text = String(dateToPrint)
        cell.labelFavoriteNumber.text = String(tweet.favoritesCount)
        cell.labelRetweetNumber.text = String(tweet.retweetCount)
        
        //user labels
        cell.labelUserName.text = tweet.userName
        cell.labelUserHandle.text = "@\(tweet.userHandle!)"
        
        //user profile picture
        cell.imageProfilePicture.setImageWithURL(tweet.imageProfileURL!)
        cell.imageProfilePicture.layer.cornerRadius = 28
        cell.imageProfilePicture.clipsToBounds = true
        
        if(cell.tweet?.favorited == 0){
            cell.buttonFavorite.setImage(UIImage(named: "like-action-grey"), forState: .Normal)
            cell.labelFavoriteNumber.textColor = UIColor.grayColor()
        }
        else{
            cell.buttonFavorite.setImage(UIImage(named: "like-action-pink"), forState: .Normal)
            cell.labelFavoriteNumber.textColor = UIColor.redColor()
        }
        
        if(cell.tweet?.retweeted == 1){
            cell.buttonRetweet.setImage(UIImage(named: "retweet-action-green"), forState: .Normal)
            cell.labelRetweetNumber.textColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1)
            
        }
        else{
            cell.buttonRetweet.setImage(UIImage(named: "retweet-action-grey"), forState: .Normal)
            cell.labelRetweetNumber.textColor = UIColor.grayColor()
        }
    

    
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("DetailsVC") as! TweetsDetailViewController
        detailVC.tweet = tweets[indexPath.row]
        detailVC.rowFromTableView = indexPath.row
        self.navigationController!.pushViewController(detailVC, animated: true)
        
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





