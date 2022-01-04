//
//  AddChefView.swift
//  Kouzina
//
//  Created by Apple Esprit on 12/12/2021.
//

import Foundation
import UIKit

class AddChefView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // VAR
    var currentPhoto : UIImage?
    
    // WIDGET
    @IBOutlet weak var nomTF: UITextField!
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var imagePub: UIImageView!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS
    
    
    // ACTIONS
    @IBAction func ajouterChef(_ sender: Any) {
        
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
            return
        }
        
        if nomTF.text!.isEmpty {
            self.present(Alert.makeAlert(titre: "Error", message: "Fill the name"),animated: true)
            return
        }
        
        ChefViewModel.sharedInstance.add(chef: Chef(_id: "", nom: nomTF.text!, image: ""), uiImage: currentPhoto!) { success in
            if success {
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Chef added",action: UIAlertAction(title: "Proceed", style: .default, handler: { UIAlertAction in
                    self.dismiss(animated: true, completion: nil)
                })),animated: true)
            }
        }
    }
    
    @IBAction func changePhoto(_ sender: Any) {
        showActionSheet()
    }
    
    func camera()
    {
        let myPickerControllerCamera = UIImagePickerController()
        myPickerControllerCamera.delegate = self
        myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
        myPickerControllerCamera.allowsEditing = true
        self.present(myPickerControllerCamera, animated: true, completion: nil)
        
    }
    
    
    func gallery()
    {
        let myPickerControllerGallery = UIImagePickerController()
        myPickerControllerGallery.delegate = self
        myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerControllerGallery.allowsEditing = true
        self.present(myPickerControllerGallery, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            
            return
        }
        
        currentPhoto = selectedImage
        imagePub.image = selectedImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(){
        
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
        { action -> Void in
            self.camera()
        }
        actionSheetController.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
        { action -> Void in
            self.gallery()
        }
        
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
}
