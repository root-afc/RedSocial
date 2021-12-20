//
//  ViewController.swift
//  AppRedSocial
//
//  Created by admin on 12/10/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var RegistrarseButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements() {
        Utilities.styleFilledButton(RegistrarseButton)
        Utilities.styleHollowButton(loginButton)
    }
}

