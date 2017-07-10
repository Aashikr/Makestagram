//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Sakada Lim on 7/7/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    // MARK: - Subviews
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var posts = [Post]()
    
    // MARK: - VC Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserService.posts(for: User.current){(posts) in
        self.posts = posts
        self.tableView.reloadData()
        }
    }
    
    
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
}
