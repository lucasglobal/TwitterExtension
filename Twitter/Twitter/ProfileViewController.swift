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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        
        TwitterClient.sharedInstance.otherUserhomeTimeLine(userHandleFromCell, sucess: { (dictionaries: [NSDictionary]) -> () in
            
            self.userDictionary = dictionaries[0]["user"] as! NSDictionary
            print(self.userDictionary)
            
            self.imageHeaderView.setImageWithURL(NSURL(string: self.userDictionary!["profile_banner_url"] as! String)!)
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
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
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
