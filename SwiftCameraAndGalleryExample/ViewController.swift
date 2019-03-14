//
//  ViewController.swift
//  SwiftCameraAndGalleryExample
//
//  Created by Pritesh Patel on 2019-03-13.
//  Copyright © 2019 Pritesh Patel. All rights reserved.
//https://hackernoon.com/swift-access-ios-camera-and-photo-library-dc1dbe0cdd76
//https://www.ioscreator.com/tutorials/take-photo-ios-tutorial

import UIKit
import MobileCoreServices

class ViewController: UIViewController
{
    @IBOutlet weak var imgPhoto: UIImageView!
    var newMedia: Bool?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

    @IBAction func btnGalleryClick(_ sender: UIBarButtonItem)
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeImage as String]
            myPickerController.allowsEditing = false
            self.present(myPickerController, animated: true, completion: nil)
            newMedia = false
        }
    }
    
    @IBAction func btnCameraClick(_ sender: UIBarButtonItem)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            myPickerController.mediaTypes = [kUTTypeImage as String]
            myPickerController.allowsEditing = false
            self.present(myPickerController, animated: true, completion: nil)
            newMedia = true
        }
    }
    
    
}

extension ViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgPhoto.image = image
            //Save Image if taken from Camera
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
        }else{
            print("Something went wrong")
        }
        
        //Display all keys
        for (k, _) in info {
            print("TEST - \(k)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
}

