//
//  TotalUsersTableViewCell.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 9/12/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class TotalUsersTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var FollowersQuantityLabel: UILabel!
    @IBOutlet weak var FullNameLabel: UILabel!
    
    
    func configure(fullname: String, followers: Int)
    {
        FullNameLabel.text = fullname
        FollowersQuantityLabel.text = String(followers)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
