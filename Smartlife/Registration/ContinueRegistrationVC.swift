//
//  ContinueRegistrationVC.swift
//  Smartlife
//
//  Created by Queralt Sosa Mompel on 31/8/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ContinueRegistrationVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var typeOfUserPicker: UISegmentedControl!
    let imagePicker = UIImagePickerController()
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        addNavBarImage()
        self.username.setBottomBorder(withColor: UIColor.black)
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
    
    func saveImage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("profile_image_urls").child("\(uid).png")
        
        guard let imageData = UIImageJPEGRepresentation(profilePic.image!, 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL { url, error in
                }
            } else {
                let title = "Failed to save photo"
                self.alert(titleParam: title, messageParam : (error?.localizedDescription)!)
            }
        }
    }
    
    
    func sendEmail() {
        Auth.auth().currentUser?.sendEmailVerification { (error) in
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
                        self.performSegue(withIdentifier: "LoginView", sender: self)
                    }
                }
            }
        }
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
    
    
    @IBAction func pickPhoto(_ sender: Any) {
        let alertController = UIAlertController.init(title:"Select a photo", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Gallery", style: .default, handler: { (action) in
            self.photoFromGallery()
        }))
        alertController.addAction(UIAlertAction.init(title: "Camera", style: .default, handler: { (action) in
            self.shootPhoto()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func saveUserInfo() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var typeofuser = ""
        
        if(typeOfUserPicker.selectedSegmentIndex == 0) {
             typeofuser = "Distributor"
        } else if(typeOfUserPicker.selectedSegmentIndex == 1) {
             typeofuser = "Client"
        }
        
        let ref = Database.database().reference()
    
        ref.child("User Info/\(uid)/Username").setValue(username.text)
        ref.child("User Info/\(uid)/Type of user").setValue(typeofuser)
    }
    
    @IBAction func saveInfo(_ sender: Any) {
        saveImage()
        saveUserInfo()
        sendEmail()
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [String:Any]) {
        if let im = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePic.image = im
            profilePic.contentMode = .scaleAspectFit
        } 
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
