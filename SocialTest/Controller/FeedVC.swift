//
//  FeedVC.swift
//  SocialTest
//
//  Created by Globes Design on 06/12/2018.
//  Copyright © 2018 Globes Design. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func SIgnInTapped(_ sender: Any) {
           KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        
           let firebaseAuth = Auth.auth()
            do {
                 try firebaseAuth.signOut()
             } catch let signOutError as NSError {
                 print("Error signing out: %@", signOutError)
             }
        
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }
    
}
