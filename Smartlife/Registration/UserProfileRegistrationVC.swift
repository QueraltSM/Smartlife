//
//  UserProfileRegistrationVC.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 4/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit

class UserProfileRegistrationVC: UIViewController {

    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var username: UITextField!
    
    
    func setDesign() {
        self.username.setBottomBorder(withColor: UIColor.black)
        self.username.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "username.png")
        imageView.image = image
        self.username.leftView = imageView
        self.signUpButton.layer.borderWidth = 2.0
        self.signUpButton.layer.borderColor = UIColor.black.cgColor
        self.signUpButton.layer.cornerRadius = 10
    }
    
    
    func addNavBarImage() {
        let navController = navigationController!
        navController.navigationBar.barTintColor = UIColor.white
        let image = UIImage(named: "Herbalife.jpg") //Your logo url here
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        //let imgTitle = UIImage(named: "Icon.png")
        //navigationItem.titleView = UIImageView(image: imgTitle)
        setDesign()
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

