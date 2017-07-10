//
//  UserService.swift
//  Makestagram
//
//  Created by Sakada Lim on 7/7/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth.FIRAuth
import FirebaseAuth.FIRUser


struct UserService {
    static func create(_ firUser: FIRUser, username: String, completion: @escaping(User?)->Void){
        let userAttrs = ["username" : username]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs){ (error,ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?)->Void){
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(user)
        })
    }
    
    static func posts(for user: User, completion: @escaping ([Post])->Void){
        let ref = Database.database().reference().child("post").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            let posts = snapshot.reversed().flatMap(Post.init)
            completion(posts)
            })
    }
}
