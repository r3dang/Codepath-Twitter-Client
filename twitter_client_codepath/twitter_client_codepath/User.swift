//
//  User.swift
//  twitter_client_codepath
//
//  Created by Rajit Dang on 2/27/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileURL: URL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String as String?
        screenname = dictionary["screen_name"] as? String as String?
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)!
        }
        
        tagline = dictionary["description"] as? String

    }
    static var _currentUser: User?
    static var userDidLogoutNotification = "UserDidLogout"
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                if let userData  = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
}
