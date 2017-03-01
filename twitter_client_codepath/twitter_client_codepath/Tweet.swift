 //
//  Tweet.swift
//  twitter_client_codepath
//
//  Created by Rajit Dang on 2/27/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweet_count: Int = 0
    var favorites_count: Int = 0
    var user: NSDictionary?
    var username: String?
    var profileUrl: URL?
    var id: String?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        user = dictionary["user"] as? NSDictionary!
        username = user!["name"] as? String
        retweet_count = (dictionary["retweet_count"] as? Int) ?? 0
        favorites_count = (dictionary["favourites_count "] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        
        profileUrl = URL(string: (user!["profile_image_url_https"] as? String)!)
        id = user?["screen_name"] as? String
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
