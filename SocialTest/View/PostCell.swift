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
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configeCell(post: Post, img: UIImage? = nil){
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil{
            self.postImage.image = img
        }
        else {
                let ref = Storage.storage().reference(forURL: post.imageUrl)
                ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if error != nil {
                        print("itay: error - get image")
                        print(error.debugDescription)
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
    }
}
