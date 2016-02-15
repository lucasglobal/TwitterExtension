//
//  TwitterClient.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/14/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

let twitterConsumerKey = "H5OnHspgCZ4EvxX10OgX5As2Y"
let twitterConsumerSecret = "Gkz47BQJhabBlF5DjkKHbQQgyZeaXrHCowDHWja3XOltT7dO3V"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
