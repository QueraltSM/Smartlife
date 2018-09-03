//
//  ConfigurationVC.swift
//  Herbalife
//
//  Created by Queralt Sosa Mompel on 7/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class ConfigurationVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var menu_vc : SideMenuVC!
    let imagePicker = UIImagePickerController()
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var menu_bt: UIButton!
    @IBOutlet var username: UITextField!
    
    @IBOutlet var delBtn: UIButton!
    @IBOutlet var passBtn: UIButton!
    @IBOutlet var emailBtn: UIButton!
    
    @IBAction func openMenu(_ sender: Any) {
        if AppDelegate.menu_bool {
            showMenu()
            // ixono para cerrar / foto = X
            //menu_bt.title = "x"
        } else {
            // ixono para abrir / foto = III
            //menu_bt.title = "_"
            closeMenu()
        }
    }
    
    
    func setDesign() {
        self.delBtn.layer.borderWidth = 4.0
        self.delBtn.layer.borderColor = UIColor.black.cgColor
        
        self.passBtn.layer.borderWidth = 4.0
        self.passBtn.layer.borderColor = UIColor.black.cgColor
        
        self.emailBtn.layer.borderWidth = 4.0
        self.emailBtn.layer.borderColor = UIColor.black.cgColor
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
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera",message: "Sorry, this device has no camera",preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,animated: true,completion: nil)
    }
    
    func shootPhoto () {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    func photoFromGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func savePhotoFirebase(){
        let alert = UIAlertController(title: "Do you want to save this new profile photo?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            guard let imageData = UIImageJPEGRepresentation(self.imageView.image!, 0.5) else {return}
            
            let profileImgReference = Storage.storage().reference().child("profile_image_urls").child("\(uid).png")
            let uploadTask = profileImgReference.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    self.alert(titleParam: "Error uploading profile photo", messageParam : error.localizedDescription)
                } else {
                    self.alert(titleParam: "Change profile photo was successful", messageParam : "")
                }
            }
            uploadTask.observe(.progress, handler: { (snapshot) in
                print(snapshot.progress?.fractionCompleted ?? "")
            })
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in}
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
    }
    
    @IBAction func changePhoto(_ sender: Any) {
        let alertController = UIAlertController.init(title:"Select a photo", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Gallery", style: .default, handler: { (action) in
            self.photoFromGallery()
        }))
        alertController.addAction(UIAlertAction.init(title: "Camera", style: .default, handler: { (action) in
            self.shootPhoto()
        }))
        self.present(alertController, animated: true, completion: nil)
        
       savePhotoFirebase()
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
        let alertChange = UIAlertController(title: "Change password", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alertChange.textFields![0] as UITextField
            if let user = Auth.auth().currentUser {
             user.updatePassword(to: textField.text!, completion: { (error) in
             if let error = error {
                self.alert(titleParam: "Error change password", messageParam : error.localizedDescription)
             } else {
                self.alert(titleParam: "Change password was successful", messageParam : "")
                }
             })
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in}
        
        alertChange.addTextField { (textField) in
            textField.placeholder = "New password"
            textField.isSecureTextEntry = true
        }
        
        alertChange.addAction(action)
        alertChange.addAction(cancel)
        self.present(alertChange, animated:true, completion: nil)
    }
    
    
    @IBAction func deleteAccount(_ sender: Any) {
        // Also must delete user's info on the Storage Firebase
        
        let alertController = UIAlertController(title: "Are you sure you want to delete your account?", message: "", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let user = Auth.auth().currentUser
            user?.delete (completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let storyboard = self.storyboard {
                        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! UINavigationController
                        self.present(vc, animated: false, completion: nil)
                    }
                }
            })
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
        }
        alertController.addAction(cancel)
        alertController.addAction(yes)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func changeEmail(_ sender: Any) {
        let alertChange = UIAlertController(title: "Change email", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alertChange.textFields![0] as UITextField
            if let user = Auth.auth().currentUser {
                user.updateEmail(to: textField.text!, completion: { (error) in
                    if let error = error {
                        self.alert(titleParam: "Error change email", messageParam : error.localizedDescription)
                    } else {
                        self.alert(titleParam: "Change email was successful", messageParam : "")
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            if error != nil {
                                let title = "Error sending email to verify account"
                                self.alert(titleParam: title, messageParam : (error?.localizedDescription)!)
                            } else {
                                let title = "Verify new email"
                                let message = "We have sent you an email, please check it out"
                                self.alert(titleParam: title, messageParam: message)
                                self.performSegue(withIdentifier: "Login", sender: self)
                            }
                        }
                    }
                })
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in}
        
        alertChange.addTextField { (textField) in
            textField.placeholder = "New email"
        }
        
        alertChange.addAction(action)
        alertChange.addAction(cancel)
        self.present(alertChange, animated:true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
     func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesign()
        
        imagePicker.delegate = self
        self.username.setBottomBorder(withColor: UIColor.black)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "username.png")
        imageView.image = image
        self.username.leftView = imageView
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "Menu") as! SideMenuVC
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
