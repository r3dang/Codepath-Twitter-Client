//
//  ProfileViewController.swift
//  twitter_client_codepath
//
//  Created by Rajit Dang on 3/9/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var tweet: Tweet!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        profilePic.setImageWith(tweet!.profileUrl!)
        numTweets.text = "\(tweet.retweet_count)"
        numFollowers.text = "\(tweet.followersCount)"
        numFollowing.text = "\(tweet.followingCount)"
        username.text = "\(tweet.username!)"
    }
    
    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
