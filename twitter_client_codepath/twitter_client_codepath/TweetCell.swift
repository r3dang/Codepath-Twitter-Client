//
//  TableViewCell.swift
//  twitter_client_codepath
//
//  Created by Rajit Dang on 2/28/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweeterLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            descriptionLabel.text = tweet.text!
            userHandleLabel.text = "@\(tweet.id!)"
            
            let date = tweet.timestamp!
            let difference = (Int)(Date().timeIntervalSince(date))
            let new_diff = convertDifference(difference: difference)
//            let formatter = DateFormatter()
//            formatter.dateFormat = "EEE MMM d H:mm a"
//            let formattedTimeStamp = formatter.string(from: tweet.timestamp!)
            timeLabel.text = "\(new_diff)"
            tweetImageView.setImageWith((tweet!.profileUrl!))
            favoriteCount.text = "\(tweet.favorites_count)"
            retweetCount.text = "\(tweet.retweet_count)"
            tweeterLabel.text = "\(tweet.username!)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func retweet(_ sender: Any) {
        TwitterClient.sharedInstance?.retweet(id: tweet.id!, success: { (count: String) in
            self.retweetCount.text = "\(count)"
            self.retweetCount.setNeedsDisplay()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func favorite(_ sender: Any) {
        TwitterClient.sharedInstance?.favorite(id: tweet.id!, success: { (count: String) in
            self.favoriteCount.text = "\(count)"
            self.favoriteCount.setNeedsDisplay()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
            
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func convertDifference(difference: Int) -> String{
        
        var new_diff: Int
        var ret_val: String
        
        //if within an min, leave as seconds
        if(difference < 60){
            ret_val = "\(difference)s"
        }
        
        //if within an hr, convert to minutes
        if(difference < 3600){
            new_diff = (Int) (difference/60)
            ret_val = "\(new_diff)m"
        }
            
            // if within 24 hrs, convert to hrs
        else if (difference < (3600*24)){
            new_diff = (Int) ((difference/60) / 60)
            ret_val = "\(new_diff)hr"
            
        }
            
            // if within a week, convert to days
        else if (difference < (3600*24*7)){
            new_diff = (Int) (((difference/60) / 60) / 24)
            ret_val = "\(new_diff)d"
        }
            
            // if within a month, convert to week
        else if (difference < (3600*24*7*30)){
            new_diff = (Int) ((((difference/60) / 60) / 24) / 7)
            ret_val = "\(new_diff)wk"
            
        }
            
            // if within a year, convert to months
        else if(difference < (3600*24*7*30*12)){
            new_diff = (Int) (((((difference/60) / 60) / 24) / 7) / 30)
            ret_val = "\(new_diff)m"
        }
            
            // convert to years
        else{
            new_diff = (Int) (((((difference/60) / 60) / 24) / 7) / 30) / 12
            ret_val = "\(new_diff)yr"
            
        }
        
        return ret_val
        
    }
    
    
    
}
