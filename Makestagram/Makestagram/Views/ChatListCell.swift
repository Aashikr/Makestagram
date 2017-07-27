//
//  ChatListCell.swift
//  Makestagram
//
//  Created by Sakada Lim on 7/27/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {
    
    // MARK: - Subviews
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    // MARK: - Cell Lifcycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - IBActions
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        print("dismiss button tapped")
    }
}
