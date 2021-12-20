//
//  TableViewCell.swift
//  AppRedSocial
//
//  Created by admin on 12/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var ownerLabel: UILabel!
    
    @IBOutlet weak var PostLabel: UILabel!
    
    @IBOutlet weak var quantityLikesLabel: UILabel!
    
    @IBOutlet weak var CellView: UIView!
    
    
    func configure(comments: String, fullname: String, quantity: Int)
    {
        ownerLabel.text = fullname
        PostLabel.text = comments
        quantityLikesLabel.text = String(quantity)
        CellView.layer.shadowColor = UIColor.gray.cgColor
        CellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        CellView.layer.shadowOpacity = 1.0
        CellView.layer.masksToBounds = false
        CellView.layer.cornerRadius = 2.0
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
