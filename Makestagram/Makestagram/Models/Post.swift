//
//  Post.swift
//  Makestagram
//
//  Created by Sakada Lim on 7/10/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    var key: String?
    let imageURL: String
    let imageHeight: CGFloat
    let creationDate: Date
    
    init(imageURL: String, imageHeight: CGFloat) {
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date()
    }
    
    var dictValue: [String: Any]{
        let createdAgo = creationDate.timeIntervalSince1970
        
        return ["image_url": imageURL, "image_height": imageHeight, "created_at": createdAgo]
    }
}
