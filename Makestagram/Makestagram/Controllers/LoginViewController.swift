//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Sakada Lim on 7/6/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabase


typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton){
        print("Login button tapped")
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
        }
        guard let user = user
            else { return }
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        userRef.observeSingleEvent(of: .value, with: {[unowned self] (snapshot) in
            if let user = User(snapshot: snapshot){
                print("User already exists \(user.username).")
            } else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
        })
    }
}
