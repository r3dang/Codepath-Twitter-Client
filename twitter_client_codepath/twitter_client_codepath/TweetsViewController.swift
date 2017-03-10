//
//  TweetsViewController.swift
//  twitter_client_codepath
//
//  Created by Rajit Dang on 2/28/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tweets: [Tweet]!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.estimatedRowHeight = 125
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = self.tweets![indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![(indexPath!.row)]
            
            let detailedViewController = segue.destination as! TweetDetailedViewController
            detailedViewController.tweet = tweet
        }
        else if (segue.identifier == "profile") {
            let cellButton = sender as! UIButton
            let cell = cellButton.superview?.superview as! TweetCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![(indexPath!.row)]
            
            let navController = segue.destination as! UINavigationController
            let profileViewController = navController.viewControllers[0] as! ProfileViewController
            profileViewController.tweet = tweet
        }
    }

}
