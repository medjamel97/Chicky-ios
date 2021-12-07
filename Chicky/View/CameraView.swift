//
//  Camera.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class CameraView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // VAR
    var currentPhoto : UIImage?
    
    // WIDGET
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var imagePub: UIImageView!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS
    
    
    // ACTIONS
    @IBAction func ajouterPublication(_ sender: Any) {
        
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Choisir une image"), animated: true)
            return
        }
        
        let publication = Publication( description: descriptionTextField.text, date: Date(), commentaires: [])
        PublicationViewModel().addPublication(publication: publication, uiImage: currentPhoto!) { success in
            if success {
                self.present(Alert.makeAlert(titre: "Success", message: "Publication ajouté"),animated: true)
            }
        }
    }
    
    func loadImage() {
        /*let url = "http://localhost:3000/img/"+(user?.photo)!
        print(url)
        if user?.photo != nil {
            ImageLoader.shared.loadImage(identifier:(user?.photo)!, url: url, completion: {image in
                print(url)
                imageUser.image = image
                
            })
        }*/
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
        addImageButton.isHidden = true
        
        /*UserViewModel().uploadImageProfile(uiImage: selectedImage,completed: { success in
            if success {
                self.initializeProfile()
            }
        })*/
        
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
