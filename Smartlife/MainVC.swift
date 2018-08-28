//
//  MainVCViewController.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 5/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit

class MainVC: UIViewController {


    @IBOutlet var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpButton.layer.borderWidth = 3.0
        let color : UIColor = UIColor(red:0.21, green:0.49, blue:0.17, alpha:1.0)
        self.signUpButton.layer.borderColor =  color.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
