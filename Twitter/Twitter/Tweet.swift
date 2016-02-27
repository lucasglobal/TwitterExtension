//
//  Tweet.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/19/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    var userName: String?
    var userHandle: String?
    var imageProfileURL: NSURL?
    
    var favorited: Int = 0
    var retweeted: Int = 0
    
    var positionInArray: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        print(dictionary)
        
        let timesStampString = dictionary["created_at"] as? String
        
        if let timesStampString = timesStampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"


            timeStamp = formatter.dateFromString(timesStampString)
        }
        
        let user = dictionary["user"]
        
        //user name labels
        userName = user!["name"] as? String
        userHandle = user!["screen_name"] as? String
        
        //user picture
        imageProfileURL = NSURL(string: (user!["profile_image_url"] as! String))
        
        
        //user actions
        favorited = dictionary["favorited"] as! Int
        retweeted = dictionary["retweeted"] as! Int        
        
    }
    
    class func TweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet  = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
