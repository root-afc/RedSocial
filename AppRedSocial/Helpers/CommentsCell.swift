//
//  CommentsCell.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 29/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    
    @IBOutlet weak var fullnameTextField: UILabel!
    
    @IBOutlet weak var CommentsTextField: UILabel!
    
    @IBOutlet weak var cellView: UIView!
    
    
    func configure(fullname: String, comments: String)  {
        fullnameTextField.text = fullname
        CommentsTextField.text = comments
        
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cellView.layer.shadowOpacity = 1.0
        cellView.layer.masksToBounds = false
        cellView.layer.cornerRadius = 2.0
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
