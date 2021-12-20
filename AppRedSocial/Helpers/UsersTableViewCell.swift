//
//  UsersTableViewCell.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 8/12/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var FullNameLabel: UILabel!
    
    func configure(fullname: String)
    {
        FullNameLabel.text = fullname
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
