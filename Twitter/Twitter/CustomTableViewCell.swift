//
//  CustomTableViewCell.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/20/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelFavoriteNumber: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var labelRetweetNumber: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserHandle: UILabel!
    @IBOutlet weak var imageProfilePicture: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var buttonRetweet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var buttonFavorite: UIButton!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoriteAction(sender: AnyObject) {
        buttonFavorite.setImage(UIImage(named: "like-action-pink"), forState: .Normal)
        labelFavoriteNumber.textColor = UIColor.redColor()
        print("favoritte")
    }
    @IBAction func retweetAction(sender: AnyObject) {
        buttonRetweet.setImage(UIImage(named: "retweet-action-green"), forState: .Normal)
        labelRetweetNumber.textColor = UIColor(red: 0, green: 0.8, blue: 0, alpha: 1)
        print("retweet")
    }
}
