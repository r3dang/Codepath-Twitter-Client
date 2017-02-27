//
//  LoginViewController.swift
//  twitter_client_codepath
//
//  Created by Rajit Dang on 2/26/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginToTwitter(_ sender: Any) {
        let apiURL = URL(string: "https://api.twitter.com")
        let twitterClient = BDBOAuth1SessionManager(baseURL: apiURL, consumerKey: "5wZOeonL2PrcTtKzvma4SFoC1", consumerSecret: "qTq09tSvMpCr44dI9uwnzOUiLTU1pU1NTVILrJHBuRgzXo5oDz")
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: nil, scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("I got a token!")
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
        }
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
