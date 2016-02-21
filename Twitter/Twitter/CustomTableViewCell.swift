//
//  CustomTableViewCell.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/20/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserHandle: UILabel!
    @IBOutlet weak var imageProfilePicture: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
