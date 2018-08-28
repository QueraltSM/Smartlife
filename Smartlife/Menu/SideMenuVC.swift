//
//  SideMenuVC.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 7/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import FirebaseAuth

class SideMenuVC: UIViewController {

    @IBOutlet var home: UIButton!
    @IBOutlet var logout: UIButton!
    @IBOutlet var configuration: UIButton!
    @IBOutlet var messages: UIButton!
    
    func setDesign() {
        self.home.layer.borderWidth = 4.0
        self.home.layer.borderColor = UIColor.black.cgColor
        
        self.logout.layer.borderWidth = 4.0
        self.logout.layer.borderColor = UIColor.black.cgColor
        
        self.configuration.layer.borderWidth = 4.0
        self.configuration.layer.borderColor = UIColor.black.cgColor
        
        self.messages.layer.borderWidth = 4.0
        self.messages.layer.borderColor = UIColor.black.cgColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logout(_ sender: Any) {

        let alertController = UIAlertController(title: "Are you sure you want to log out?", message: "", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            try! Auth.auth().signOut()
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! UINavigationController
                self.present(vc, animated: false, completion: nil)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
        }
        
        alertController.addAction(cancel)
        alertController.addAction(yes)
        self.present(alertController, animated: true, completion: nil)
        
    }

}
