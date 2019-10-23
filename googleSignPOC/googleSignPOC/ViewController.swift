//
//  ViewController.swift
//  googleSignPOC
//
//  Created by Shweta Shah on 19/07/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController , GIDSignInUIDelegate {

    @IBOutlet weak var googleBtn: GIDSignInButton!
    
    @IBOutlet weak var actualBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }


}

