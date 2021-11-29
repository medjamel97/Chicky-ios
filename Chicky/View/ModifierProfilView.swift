//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ModifierProfilView: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // VAR
    var nom: String?
    var prenom : String?
    var currentImage: UIImage!
    
    // WIDGET
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var addPictureBtn: UIButton!
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePage()
    }
    
    // METHODS
    func initializePage() {
        nomTextField.text = nom
    }
    
    
    // ACTIONS
    @IBAction func modifierProfil(_ sender: Any) {
    }
    
    @IBAction func radioMale(sender: AnyObject) {
        print("Gender is Male")
    }
    
    @IBAction func radioFemale(sender: AnyObject) {
       print("Gender is Female")
    }
    
    

    @IBAction func uploadpdp(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        guard let image = info [.editedImage] as? UIImage else {
            return
        }
        dismiss(animated: true)
        
        currentImage = image
    }
    
    
}
