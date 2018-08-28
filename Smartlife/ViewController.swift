//
//  ViewController.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 3/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            self.performSegue(withIdentifier: "Login", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UITextField {
    func setBottomBorder(withColor color: UIColor) {
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = 2.0
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
        self.tintColor = .orange
        
    }
}
