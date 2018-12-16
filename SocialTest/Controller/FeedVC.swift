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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    @IBOutlet weak var imageAdd: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postc = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            let imgns = postc.imageUrl as NSString
            if let img = FeedVC.imageCache.object(forKey: imgns){
                cell.configeCell(post: postc, img: img)
            }
            else{
                cell.configeCell(post: postc, img: nil)
            }
        
            return cell
        }
        else {
            return PostCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageAdd.image = image
        }
        else {
            print("itay: a valid image wasn't selected")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}
