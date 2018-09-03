//
//  HomeVC.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 7/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet var profile_Pic: UIImageView!
    @IBOutlet var username: UILabel!
    
    var menu_vc : SideMenuVC!
    @IBOutlet var menu_bt: UIBarButtonItem!
    
    @IBAction func openMenu(_ sender: Any) {
        if AppDelegate.menu_bool {
            showMenu()
            // ixono para cerrar / foto = X
            menu_bt.title = "x"
        } else {
            // ixono para abrir / foto = III
            menu_bt.title = ""
            closeMenu()
        }
    }
    
    func retrieveUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference(withPath: "User Info/\(uid)/")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            
            let user = snapshot.childSnapshot(forPath: "Username").value
            self.username.text = user as! String
        })
        
        
        let photo =  Storage.storage().reference().child("profile_image_urls").child("\(uid).png")
        
        photo.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {

                let image = UIImage(data: data!)
                self.profile_Pic.image = image
                self.profile_Pic.contentMode = .scaleAspectFit
            }
        }
        
        

    }
    
    @objc func respondToGesture(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            showMenu()
        case UISwipeGestureRecognizerDirection.left:
            close_on_swipe()
        default:
            break
        }
    }
    
    func close_on_swipe() {
        if AppDelegate.menu_bool {
            showMenu()
        } else {
            closeMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveUserInfo()
        
        self.profile_Pic.layer.borderColor =  UIColor.black.cgColor
        self.profile_Pic.layer.borderWidth = 2
        
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "Menu") as! SideMenuVC
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func closeMenu() {
        self.menu_vc.view.removeFromSuperview()
        AppDelegate.menu_bool = true
    }
    
    
    func showMenu () {
        self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addChildViewController(menu_vc)
        self.view.addSubview(menu_vc.view)
        AppDelegate.menu_bool = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
