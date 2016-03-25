//
//  ProfileViewController.swift
//  SampleApp
//
//  Created by Ritesh Chopra on 22/02/16.
//  Copyright © 2016 Gurdev Singh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var tf_userName: UITextField!
    @IBOutlet var tf_email: UITextField!
    @IBOutlet var tf_contactNumber: UITextField!
    @IBOutlet var tf_OldPassword: UITextField!
    @IBOutlet var tf_NewPassword: UITextField!
    @IBOutlet var profileImg: UIButton!
    @IBOutlet var backgroundImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profileImg.layer.cornerRadius = 45
        profileImg.layer.borderColor = UIColor.blackColor().CGColor
        profileImg.layer.borderWidth  = 1.0
        profileImg.layer.masksToBounds = true
        backgroundImg.layer.masksToBounds = true
    
    }
    
    //MARK:- Slide Right Menu Delegate
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
  
    @IBAction func managePhotoAction(sender: AnyObject) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let cameraAction = UIAlertAction(title: "Take photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Deleted")
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
            {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                imagePickerController.allowsEditing = true
                self.presentViewController(imagePickerController, animated: true, completion: { imageP in
                    
                })
            }
        
        })
        
        let libraryAction = UIAlertAction(title: "Select photo from library", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.allowsEditing = true
            self.presentViewController(imagePickerController, animated: true, completion: { imageP in
                
            })
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        // 4
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(libraryAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        picker .dismissViewControllerAnimated(true, completion: nil)
        let selectedImage : UIImage = image
        backgroundImg.image = selectedImage
        profileImg.setBackgroundImage(selectedImage, forState: UIControlState.Normal)
        //print(selectedImage)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func submitButtonAction(sender: AnyObject) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
