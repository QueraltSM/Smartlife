//
//  HomeVC.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 7/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
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
