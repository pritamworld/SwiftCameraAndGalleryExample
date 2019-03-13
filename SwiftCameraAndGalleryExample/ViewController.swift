//
//  ViewController.swift
//  SwiftCameraAndGalleryExample
//
//  Created by Pritesh Patel on 2019-03-13.
//  Copyright © 2019 Pritesh Patel. All rights reserved.
//https://hackernoon.com/swift-access-ios-camera-and-photo-library-dc1dbe0cdd76
//https://www.ioscreator.com/tutorials/take-photo-ios-tutorial

import UIKit

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
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCameraClick(_ sender: UIBarButtonItem)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    
}

extension ViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgPhoto.image = image
        }else{
            print("Something went wrong")
        }
        
        for (k, _) in info {
            print("TEST - \(k)")
        }
        self.dismiss(animated: true, completion: nil)
    }
}

