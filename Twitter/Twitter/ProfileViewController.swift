//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/27/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var blurredViewBlue: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelScreenName: UILabel!
    @IBOutlet weak var labelNumberOfFollowers: UILabel!
    @IBOutlet weak var labelNumberOfFollowing: UILabel!
    @IBOutlet weak var imageHeaderView: UIImageView!
    
    var userHandleFromCell: String!
    
    var userDictionary: NSDictionary!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        TwitterClient.sharedInstance.otherUserhomeTimeLine(userHandleFromCell, sucess: { (dictionaries: [NSDictionary]) -> () in
            self.tweets = Tweet.TweetsWithArray(dictionaries)

        
            
            
            self.userDictionary = dictionaries[0]["user"] as! NSDictionary
            
            if (self.userDictionary!["profile_banner_url"]) != nil {
                self.imageHeaderView.setImageWithURL(NSURL(string: self.userDictionary!["profile_banner_url"] as! String)!)
            }
            self.imageProfile.setImageWithURL(NSURL(string: self.userDictionary!["profile_image_url"] as! String)!)
            self.imageProfile.layer.cornerRadius = 50
            self.imageProfile.clipsToBounds = true
            
            self.labelName.text = self.userDictionary!["name"] as? String
            self.labelScreenName.text = "@\(self.userDictionary!["screen_name"]!)"
            self.labelNumberOfFollowers.text = "\(self.userDictionary!["followers_count"]!)"
            self.labelNumberOfFollowing.text = "\(self.userDictionary!["following"]!)"
        
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.blurredViewBlue.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.blurredViewBlue.addSubview(blurEffectView)
            
            self.tableView.reloadData()
            
            
            }) { (NSError) -> () in
                print("problem fetching other user profile")
        }        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets{
            return tweets.count
        }
        else{
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellProfile", forIndexPath: indexPath) as! CustomTableViewCell
        let tweet = tweets[indexPath.row]
        
        tweet.positionInArray = indexPath.row
        cell.tweet = tweet
        cell.tag = indexPath.row
        
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
        
        
        

        print(cell)
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
