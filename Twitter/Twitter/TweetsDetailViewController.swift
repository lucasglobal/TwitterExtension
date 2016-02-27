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
        
        
        //setting labels with User Data
        self.imageProfilePicture.setImageWithURL(tweet!.imageProfileURL!)
        self.labelUserName.text = String(tweet!.userName)
        self.labelUserHandle.text = String(tweet!.userHandle)
        self.labelTweetText.text = String(tweet!.text!)
        self.labelFavoriteNumber.text = String(tweet!.favoritesCount)
        self.labelRetweetNumber.text = String(tweet!.retweetCount)
        self.labelDate.text = String(tweet!.timeStamp!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
