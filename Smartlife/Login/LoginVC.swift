//
//  LoginVC.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 3/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var signIn: UIButton!
    @IBOutlet var barButtonLeft: UIBarButtonItem!
    @IBOutlet var signUp: UIButton!
    
    
    func alert(titleParam : String, messageParam: String) {
        let title = titleParam
        let message = messageParam
        let okText = "Ok"
        let alert = UIAlertController(title: title, message : message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!, completion: {
            user, error in
            if error != nil {
                let title = "Error signing in"
                self.alert(titleParam: title, messageParam : (error?.localizedDescription)!)
            }
            else {
                if let user = Auth.auth().currentUser {
                    if !user.isEmailVerified {
                        let title = "Email has not been verified"
                        let message =  "Please check out your email"
                        self.alert(titleParam: title, messageParam : message)
                    } else {
                        self.performSegue(withIdentifier: "Home", sender: self)
                    }
                }
            }
        })
    }
    

    @IBAction func changeColorBorder1(_ sender: Any) {
        let color : UIColor = UIColor(red:0.21, green:0.49, blue:0.17, alpha:1.0)
        self.email.setBottomBorder(withColor: color)
    }
    
    @IBAction func changeColorBorder2(_ sender: Any) {
        self.email.setBottomBorder(withColor: UIColor.black)
    }
    
    @IBAction func changeColorBorder3(_ sender: Any) {
        let color : UIColor = UIColor(red:0.21, green:0.49, blue:0.17, alpha:1.0)
        self.password.setBottomBorder(withColor: color)
    }
    
    
    @IBAction func changeColorBorder4(_ sender: Any) {
        self.password.setBottomBorder(withColor: UIColor.black)
    }
    
    
    
    @IBAction func forgotPassword(_ sender: Any) {
        if (self.email.text == "") {
            self.email.setBottomBorder(withColor: UIColor.red)
        } else {
            Auth.auth().sendPasswordReset(withEmail: self.email.text!) { error in
                if error == nil {
                    let title = "Reset password"
                    let message = "Check your email!"
                    self.alert(titleParam: title, messageParam : message)
                } else {
                    let title = "Error reset password"
                    self.alert(titleParam: title, messageParam : (error?.localizedDescription)!)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        setDesign()
    }
    
    func setDesign() {
        self.email.setBottomBorder(withColor: UIColor.black)
        self.password.setBottomBorder(withColor: UIColor.black)
        self.email.attributedPlaceholder = NSAttributedString(string:"Email address", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        self.password.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        self.signIn.layer.borderWidth = 3.0
        self.signIn.layer.borderColor = UIColor.black.cgColor
        //self.signIn.layer.cornerRadius = 10
        
        self.signUp.layer.borderWidth = 3.0
        let color : UIColor = UIColor(red:0.21, green:0.49, blue:0.17, alpha:1.0)
        self.signUp.layer.borderColor =  color.cgColor
    
        self.email.leftViewMode = UITextFieldViewMode.always
        self.password.leftViewMode = UITextFieldViewMode.always
        let imageViewEmail = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let imageViewPassword = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let imageEmail = UIImage(named: "email.png")
        imageViewEmail.image = imageEmail
        let imagePassword = UIImage(named: "password.png")
        imageViewPassword.image = imagePassword
        self.email.leftView = imageViewEmail
        self.password.leftView = imageViewPassword
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addNavBarImage() {
        let navController = navigationController!      
        navController.navigationBar.barTintColor = UIColor.white
        let image = UIImage(named: "Herbalife.jpg")
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
