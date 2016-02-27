//
//  TweetsDetailViewController.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/26/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class TweetsDetailViewController: UIViewController {
    var tweet: Tweet?
    var rowFromTableView: Int = 0
    
    
    @IBOutlet weak var imageProfilePicture: UIImageView!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelUserHandle: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelTweetText: UILabel!
    
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBOutlet weak var labelRetweetNumber: UILabel!
    @IBOutlet weak var labelFavoriteNumber: UILabel!
    
    @IBOutlet weak var buttonRetweet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //change backbutton to white
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        //setting labels and picture with User Data
        self.imageProfilePicture.setImageWithURL(tweet!.imageProfileURL!)
        self.imageProfilePicture.layer.cornerRadius = 28
        self.imageProfilePicture.clipsToBounds = true
        self.labelUserName.text = String(tweet!.userName!)
        self.labelUserHandle.text = "@\(tweet!.userHandle!)"
        self.labelTweetText.text = String(tweet!.text!)
        self.labelFavoriteNumber.text = String(tweet!.favoritesCount)
        self.labelRetweetNumber.text = String(tweet!.retweetCount)
        self.labelDate.text = String(tweet!.timeStamp!)
        
        if(tweet?.favorited == 1){
            buttonFavorite.setImage(UIImage(named: "like-action-pink"), forState: .Normal)
            labelFavoriteNumber.textColor = UIColor.redColor()
            
        }
        else{
            buttonFavorite.setImage(UIImage(named: "like-action-grey"), forState: .Normal)
            labelFavoriteNumber.textColor = UIColor.grayColor()
        }
        if(tweet?.retweeted == 1){
            buttonRetweet.setImage(UIImage(named: "retweet-action-green"), forState: .Normal)
            labelRetweetNumber.textColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1)
            
        }
        else{
            buttonRetweet.setImage(UIImage(named: "retweet-action-grey"), forState: .Normal)
            labelRetweetNumber.textColor = UIColor.grayColor()
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        if(tweet?.favorited == 0){
            buttonFavorite.setImage(UIImage(named: "like-action-pink"), forState: .Normal)
            labelFavoriteNumber.textColor = UIColor.redColor()
            tweet?.favorited = 1
            
            var pastFavorite = Int(self.labelFavoriteNumber.text!)
            pastFavorite = pastFavorite! + 1
            self.labelFavoriteNumber.text = String(pastFavorite!)
            
            tweet?.favoritesCount = tweet!.favoritesCount + 1

        }
        else{
            buttonFavorite.setImage(UIImage(named: "like-action-grey"), forState: .Normal)
            labelFavoriteNumber.textColor = UIColor.grayColor()
            tweet?.favorited = 0
            
            var pastFavorite = Int(self.labelFavoriteNumber.text!)
            pastFavorite = pastFavorite! - 1
            self.labelFavoriteNumber.text = String(pastFavorite!)
            
            tweet?.favoritesCount = tweet!.favoritesCount - 1

        }
        
        
    }
    @IBAction func retweetAction(sender: AnyObject) {
        if(tweet?.retweeted == 0){
            buttonRetweet.setImage(UIImage(named: "retweet-action-green"), forState: .Normal)
            labelRetweetNumber.textColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1)
            tweet?.retweeted = 1
            
            var pastRetweet = Int(self.labelRetweetNumber.text!)
            pastRetweet = pastRetweet! + 1
            self.labelRetweetNumber.text = String(pastRetweet!)
            
            tweet?.retweetCount = tweet!.retweetCount + 1

        }
        else{
            buttonRetweet.setImage(UIImage(named: "retweet-action-grey"), forState: .Normal)
            labelRetweetNumber.textColor = UIColor.grayColor()
            tweet?.retweeted = 0
            
            
            var pastRetweet = Int(self.labelRetweetNumber.text!)
            pastRetweet = pastRetweet! - 1
            self.labelRetweetNumber.text = String(pastRetweet!)

            tweet?.retweetCount = tweet!.retweetCount - 1

        }
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        print("dasdas")
        let tweetsViewController = self.navigationController?.viewControllers[0] as? TweetsViewController
        tweetsViewController?.tweets[rowFromTableView] = tweet!
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
