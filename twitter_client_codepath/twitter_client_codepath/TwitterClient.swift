//
//  TwitterClient.swift
//  twitter_client_codepath
//
//  Created by Rajit Dang on 2/27/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: 	"5wZOeonL2PrcTtKzvma4SFoC1", consumerSecret: "qTq09tSvMpCr44dI9uwnzOUiLTU1pU1NTVILrJHBuRgzXo5oDz")
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
        
    }
    
    func currentAccount() {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            print("user: \(user)")
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile_url: \(user.profileURL)")
            print("description: \(user.tagline)")
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            
        })

    }
}
