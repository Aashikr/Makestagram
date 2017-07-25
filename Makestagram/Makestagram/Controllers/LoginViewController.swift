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
import FirebaseFacebookAuthUI
import FirebaseGoogleAuthUI



typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    // MARK: Outlet
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: UIButton){
        print("Login button tapped")
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        
        let providers: [FUIAuthProvider] = [FUIGoogleAuth(), FUIFacebookAuth()]
        authUI.providers = providers
        
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
        }
        guard let user = user
            else { return }
        UserService.show(forUID: user.uid) {(user) in
            if let user = user {
                
                User.setCurrent(user, writeToUserDefaults: true)
                let initialViewControler = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewControler
                self.view.window?.makeKeyAndVisible()
                
                } else {
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
    }
}
