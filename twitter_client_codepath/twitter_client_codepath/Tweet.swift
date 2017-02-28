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
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweet_count = (dictionary["retweet_count"] as? Int) ?? 0
        favorites_count = (dictionary["favourites_count "] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
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
