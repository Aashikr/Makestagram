//
//  PostService.swift
//  Makestagram
//
//  Created by Sakada Lim on 7/10/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    static func create(for image: UIImage){
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef){ (downloadURL) in
            guard let downloadURL = downloadURL else { return }
            
        let urlString = downloadURL.absoluteString
        let aspectHeight = image.aspectHeight
        create(forURLString: urlString, aspectHeight: aspectHeight)
        }
    }
    
    private static func create(forURLString URLString: String, aspectHeight: CGFloat){
        let currentUser = User.current
        let post = Post(imageURL: URLString, imageHeight: aspectHeight)
        let dict = post.dictValue
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        postRef.updateChildValues(dict)
        
    }
}
