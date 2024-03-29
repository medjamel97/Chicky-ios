//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ModifierProfilView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // VAR
    var utilisateur: Utilisateur?
    var currentPhoto : UIImage?
    
    // WIDGET
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dateNaissancePicker: UIDatePicker!
    @IBOutlet weak var sexeChooser: UISegmentedControl!
    
    @IBOutlet weak var addPictureBtn: UIButton!
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    // METHODS
    func initializePage() {
        UtilisateurViewModel().recupererUtilisateurParToken(userToken: UserDefaults.standard.string(forKey: "tokenConnexion")!) { [self] success, result in
            self.utilisateur = result
            
            nomTextField.text = result?.nom
            prenomTextField.text = result?.prenom
            
            if (result?.sexe)! {
                sexeChooser.selectedSegmentIndex = 1
            } else {
                sexeChooser.selectedSegmentIndex = 2
            }
            
            dateNaissancePicker.date = (utilisateur?.dateNaissance)!
            
            ImageLoader.shared.loadImage(identifier: (utilisateur?.idPhoto)!, url: IMAGE_URL + (utilisateur?.idPhoto)!) { imageResp in
                
                profileImage.image = imageResp
            }
        }
    }
    
    // ACTIONS
    @IBAction func modifierProfil(_ sender: Any) {
        print("Edited profile")
        
        if (nomTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your firstname"), animated: true)
            return
        }
        
        if (prenomTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your lastname"), animated: true)
            return
        }
        
        if (sexeChooser.selectedSegmentIndex == 0 ){
            self.present(Alert.makeAlert(titre: "Error", message: "Please choose your gender"), animated: true)
            return
        }
        
        
        //utilisateur?.idPhoto = ""
        utilisateur?.score = 0
        utilisateur?.bio = ""
        utilisateur?.nom = nomTextField.text
        utilisateur?.prenom = prenomTextField.text
        utilisateur?.dateNaissance = dateNaissancePicker.date
        
        if (sexeChooser.selectedSegmentIndex == 1 ){
            utilisateur?.sexe = true
        } else if (sexeChooser.selectedSegmentIndex == 2){
            utilisateur?.sexe = false
        }
        
        
        UtilisateurViewModel().manipulerUtilisateur(utilisateur: utilisateur!,methode: .put, completed: { (success) in
            print(success)
            if success {
            } else {
                
            }
        })
        
        self.dismiss(animated: true, completion: nil)
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
        UtilisateurViewModel().changerPhotoDeProfil(email: (utilisateur?.email)!, uiImage: selectedImage,completed: { [self] success in
            if success {
                profileImage.image = selectedImage
                self.present(Alert.makeAlert(titre: "Succes", message: "Photo modifié avec succés"),animated: true)
            } else {
                self.present(Alert.makeServerErrorAlert(),animated: true)
            }
        })
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(){
        
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
        { action -> Void in
            self.gallery()
        }
        
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // ACTIONS
    @IBAction func changeProfilePic(_ sender: Any) {
        showActionSheet()
    }
    
    
    
}
