//
//  ViewController.swift
//  Github App
//
//  Created by Amir Daliri on 10/22/16.
//  Copyright © 2016 Amir Daliri. All rights reserved.
//

import UIKit
import GitHubAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Roll tide...
        
        GitHubAuth.shared.configure(clientId: "CLINET_ID",clientSecret: "CLIENT_SECRET")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SignInTapped(sender: AnyObject) {
        GitHubAuth.shared.signIn {error in
            print(error)
            
            print(GitHubAuth.shared.accessToken)
            print(GitHubAuth.shared.isSignedIn)
            
            let req = NSMutableURLRequest(URL: NSURL(string:"https://api.github.com/user")!)
            
            GitHubAuth.shared.authorize(req)
            print(req.allHTTPHeaderFields)
            
            GitHubAuth.shared.signOut()
            print(GitHubAuth.shared.isSignedIn)
        }
    }
}

//private func login(){
//    Alamofire.request(.GET, "https://api.github.com", parameters: ["foo": "bar"])
//        .response { (request, response, data, error) in
//            print(request)
//            print(response)
//            print(error)
//            }
//}






















