//
//  RegisterVC.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 4/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class RegisterVC: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password1: UITextField!
    @IBOutlet var password2: UITextField!

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
    
    @IBAction func register(_ sender: Any) {
        if (password1.text != password2.text) {
            let title = "Error signing up"
            let message = "Password do not match"
            self.alert(titleParam: title, messageParam : message)
            password1.text = ""
            password2.text = ""
            
        } else {
                Auth.auth().createUser(withEmail: email.text!, password: password1.text!, completion: {
                    user, error in
                    if error != nil {
                        let title = "Error signing up"
                        self.alert(titleParam: title, messageParam : (error?.localizedDescription)!)
                    }
                    else {
                        // Todo OK; seguir continueRegistration
                        // luego enviar mensaje de autentificacion
                        
                         self.performSegue(withIdentifier: "continueRegistration", sender: self)
                        
                            /*Auth.auth().currentUser?.sendEmailVerification { (error) in
                                if error != nil {
                                    let title = "Welcome to Herbalife App"
                                    self.alert(titleParam: title, messageParam : (error?.localizedDescription)!)
                                } else {
                                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                                        if error != nil {
                                            let title = "Welcome to Herbalife App"
                                            self.alert(titleParam: title, messageParam : (error?.localizedDescription)!)
                                        } else {
                                            let title = "Welcome to Herbalife App"
                                            let message = "We have sent you an email, please verify your account"
                                            self.alert(titleParam: title, messageParam: message)
                                            self.performSegue(withIdentifier: "Login", sender: self)
                                        }
                                    }
                                }
                            }*/
                        
                    }
                })
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        setDesign()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDesign() {
        
        self.email.setBottomBorder(withColor: UIColor.black)
        self.email.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        self.password1.setBottomBorder(withColor: UIColor.black)
        self.password1.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        self.password2.setBottomBorder(withColor: UIColor.black)
        self.password2.attributedPlaceholder = NSAttributedString(string:"Confirm password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        self.signUp.layer.borderWidth = 3.0
        self.signUp.layer.borderColor = UIColor.black.cgColor

        self.email.leftViewMode = UITextFieldViewMode.always
        self.password1.leftViewMode = UITextFieldViewMode.always
        self.password2.leftViewMode = UITextFieldViewMode.always
        

        let imageViewEmail = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let imageViewPassword1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let imageViewPassword2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        

        let imageEmail = UIImage(named: "email.png")
        imageViewEmail.image = imageEmail
        let imagePassword1 = UIImage(named: "password.png")
        imageViewPassword1.image = imagePassword1
        let imagePassword2 = UIImage(named: "password.png")
        imageViewPassword2.image = imagePassword2
        

        self.email.leftView = imageViewEmail
        self.password1.leftView = imageViewPassword1
        self.password2.leftView = imageViewPassword2
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
