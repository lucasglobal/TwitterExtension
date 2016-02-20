//
//  User.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/19/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileURL: NSURL?
    var tagLine: NSString?
    
    init(dictionary: NSDictionary) {
        


        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString{
            profileURL = NSURL(string: profileURLString)
        }
        tagLine = dictionary["description"] as? String
    }
}
