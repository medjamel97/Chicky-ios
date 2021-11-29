//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ModifierProfilView: UIViewController {
    
    // VAR
    var nom: String?
    var prenom : String?
 
    
    // WIDGET
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
  

    @IBOutlet  var imageView: UIImageView!
    
    
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
    
    
    @IBAction func uploadimage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    
    
    
 
    
    
}


extension ModifierProfilView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
      if  let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
       
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
