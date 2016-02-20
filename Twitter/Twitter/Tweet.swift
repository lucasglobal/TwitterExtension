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
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        
        let timesStampString = dictionary["created_at"] as? String
        
        if let timesStampString = timesStampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timesStampString)
        }
        
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
