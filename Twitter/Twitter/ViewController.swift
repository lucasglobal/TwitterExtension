//
//  ViewController.swift
//  Twitter
//
//  Created by Lucas Andrade on 2/14/16.
//  Copyright © 2016 LucasAndradeRibeiro. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLogin(sender: AnyObject) {
        let client = TwitterClient.sharedInstance
        client.login({ () -> () in
            print("I've logged in")
            self.performSegueWithIdentifier("loginSegue", sender: nil)
            }) { (error: NSError) -> () in
                print("Error login: \(error.localizedDescription)")
        }
    }
}

