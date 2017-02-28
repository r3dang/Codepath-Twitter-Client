//
//  User.swift
//  twitter_client_codepath
//
//  Created by Rajit Dang on 2/27/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String as NSString?
        screenname = dictionary["screen_name"] as? String as NSString?
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString)! as NSURL
        }
        
        tagline = dictionary["description"] as? NSString

    }
    
    class var currentUser: User? {
        get {
            return nil
        }
    }
    
}
