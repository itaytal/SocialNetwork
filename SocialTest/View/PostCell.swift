//
//  PostCell.swift
//  SocialTest
//
//  Created by Globes Design on 10/12/2018.
//  Copyright © 2018 Globes Design. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: Post!
    var likesRef: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
    }
    
    
    func configeCell(post: Post, img: UIImage? = nil){
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        likesRef = DataServices.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        if img != nil{
            self.postImage.image = img
        }
        else {
                let ref = Storage.storage().reference(forURL: post.imageUrl)
                ref.getData(maxSize: 15 * 1024 * 1024) { data, error in
                    if error != nil {
                        print("itay: error - get image")
                        print("itay: ", error.debugDescription)
                    } else {
                        // Data for "images/island.jpg" is returned
                        print("download from firebase")
                        if let image = UIImage(data: data!){
                            self.postImage.image = image
                            let snImage = post.imageUrl as NSString
                            FeedVC.imageCache.setObject(image, forKey: snImage)
                        }
                    }
                }
        }
        
        likesRef.observeSingleEvent(of: .value, with: {(snapshot) in
            if let _ = snapshot.value  as? NSNull {
                self.likeImg.image = UIImage(named: "empty-heart")
            }
            else{
                self.likeImg.image = UIImage(named: "filled-heart")
            }
        })
    }
    
    
    @objc func likeTapped(sender: UITapGestureRecognizer){
        
        likesRef.observeSingleEvent(of: .value, with: {(snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addlike: true)
                self.likesRef.setValue(true)
            }
            else{
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addlike: false)
                self.likesRef.removeValue()
            }
        })
    }
}
