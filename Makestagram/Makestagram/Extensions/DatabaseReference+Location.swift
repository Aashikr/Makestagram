//
//  DatabaseReference+Location.swift
//  Makestagram
//
//  Created by Sakada Lim on 7/13/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseReference {
    enum MGLocation {
        case root
        case postsChild(uid:String)
        case showPost(posterUID: String, postKey: String)
        case usersChild(uid: String)
        case followersChild(uid: String)
        case timelineChild(uid: String)
        case postLikesUsers(postKey: String, uid: String)
        case postLikesChild(postKey: String)
        case likeCounts(posterUID: String, postKey: String)
        
        func asDatabaseReference() -> DatabaseReference {
            let root = Database.database().reference()
            switch self {
            case .root:
                return root
            case .postsChild(let uid):
                return root.child("posts").child(uid)
            case .showPost(let posterUID, let postKey):
                return root.child("posts").child(posterUID).child(postKey)
            case .usersChild(let uid):
                return root.child("users").child(uid)
            case .followersChild(let uid):
                return root.child("followers").child(uid)
            case .timelineChild(let uid):
                return root.child("timeline").child(uid)
            case .postLikesUsers(let postKey, let uid):
                return root.child("postLikes").child(postKey).child(uid)
            case .postLikesChild(let postKey):
                return root.child("postLikes").child(postKey)
            case .likeCounts(let posterUID, let postKey):
                return root.child("posts").child(posterUID).child(postKey).child("like_count")
            }
        }
        
    }
    static func toLocation(_ location: MGLocation) -> DatabaseReference {
        return location.asDatabaseReference()
    }
}
