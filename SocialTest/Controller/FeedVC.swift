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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataServices.ds.REF_POSTS.observe(DataEventType.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
                
            }
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    


    @IBAction func SIgnOutTapped(_ sender: Any) {
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
