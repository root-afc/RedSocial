//
//  MeFeedTableViewCell.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 8/12/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class MeFeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var OwnerLabel: UILabel!
    
    @IBOutlet weak var PostLabel: UILabel!
    
    @IBOutlet weak var Cell: UIView!
    
    @IBOutlet weak var QuantitylIKES: UILabel!
    
    func configure(comments: String, fullname: String, quantity: Int)
    {
        OwnerLabel.text = fullname
        PostLabel.text = comments
        QuantitylIKES.text = String(quantity)
        Cell.layer.shadowColor = UIColor.gray.cgColor
        Cell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        Cell.layer.shadowOpacity = 1.0
        Cell.layer.masksToBounds = false
        Cell.layer.cornerRadius = 2.0
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
