//
//  ChangePasswordVC.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 7/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChangePasswordVC: UIViewController {

    @IBOutlet var oldpass: UITextField!
    @IBOutlet var newpass: UITextField!
    @IBOutlet var confirmpass: UITextField!
    
    
    func setDesign(){
        self.oldpass.setBottomBorder(withColor: UIColor.black)
        self.oldpass.attributedPlaceholder = NSAttributedString(string:"Old password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        self.newpass.setBottomBorder(withColor: UIColor.black)
        self.newpass.attributedPlaceholder = NSAttributedString(string:"New password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        self.confirmpass.setBottomBorder(withColor: UIColor.black)
        self.confirmpass.attributedPlaceholder = NSAttributedString(string:"Confirm new password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func alert(titleParam : String, messageParam: String) {
        let title = titleParam
        let message = messageParam
        let okText = "Ok"
        let alert = UIAlertController(title: title, message : message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func changePassword(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            user.updatePassword(to: newpass.text!, completion: { (error) in
                if let error = error {
                    self.alert(titleParam: "Error change password", messageParam : error.localizedDescription)
                } else {
                    // Change password was successful
                    print("ok")
                }
            })
        }
        
        
        // todos los textfield son required
        
        /*let credential = EmailAuthProvider.credential(withEmail: Auth.auth().currentUser?.email as! String, password: oldpass.text!)
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (error) in
            if error == nil {
                Auth.auth().currentUser?.updatePassword(to: self.confirmpass.text!) { (errror) in
                    self.alert(titleParam: "Change password was successful", messageParam : "")
                    if let storyboard = self.storyboard {
                        let vc = storyboard.instantiateViewController(withIdentifier: "ConfigurationVC") as! UINavigationController
                        self.present(vc, animated: false, completion: nil)
                    }
                }
            } else {
                self.oldpass.setBottomBorder(withColor: UIColor.red)
                //self.alert(titleParam: "Error, same password", messageParam : "")
                
            }
        })*/
    }

}
