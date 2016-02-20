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
    
    var loginSuccess:  (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeLine(sucess: ([Tweet]) -> (), failure: (NSError) -> ()){
        
        
        
       GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.TweetsWithArray(dictionaries)
            
            sucess(tweets)
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                failure(error)
       })

        
        
    }
    
    func currentAccount(){
        
        
       GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation:NSURLSessionDataTask!, response: AnyObject?) -> Void in
            let user = User(dictionary: response as! NSDictionary)
        
            print("user: \(user.name)")
            print("Screename: \(user.screenname)")
            print("profile url: \(user.profileURL)")
            print("description: \(user.tagLine)")
            
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting current user")
        })
    }
    func login(success: () -> (), failure: (NSError) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("Got to the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!)  -> Void in
                print("failed to get request token")
                self.loginFailure?(error)
                
        }

    }
    func handleOpenURL(url: NSURL){
        let client = TwitterClient.sharedInstance
        
        client.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: {(accessToken: BDBOAuth1Credential!) -> Void in
            client.requestSerializer.saveAccessToken(accessToken)
            
            self.loginSuccess?()
            
            }) { (error: NSError!) -> Void in
                print("failed to receive access token")
                self.loginFailure?(error)
        }

    }
}






