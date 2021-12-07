//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ModifierProfilView: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // VAR
    var utilisateur: Utilisateur?
    
    // WIDGET
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var sexeChooser: UISegmentedControl!
    
    @IBOutlet weak var addPictureBtn: UIButton!
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePage()
    }
    
    // METHODS
    func initializePage() {
        UtilisateurViewModel().recupererUtilisateurParToken(userToken: UserDefaults.standard.string(forKey: "tokenConnexion")!) { [self] success, result in
            self.utilisateur = result
            
            nomTextField.text = result?.nom
            prenomTextField.text = result?.prenom
          
            if ((result?.sexe) != nil){
                sexeChooser.selectedSegmentIndex = 1
            } else {
                sexeChooser.selectedSegmentIndex = 2
            }
        }
    }
    
    
    // ACTIONS
    @IBAction func modifierProfil(_ sender: Any) {
        
        if (nomTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Erreur", message: "Veuillez saisir votre nom"), animated: true)
            return
        }
        
        if (prenomTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Erreur", message: "Veuillez saisir votre prenom"), animated: true)
            return
        }
        
        if (sexeChooser.selectedSegmentIndex == 0 ){
            self.present(Alert.makeAlert(titre: "Erreur", message: "Veuillez saisir votre sexe"), animated: true)
            return
        }
        
        
       
        /*if (dateDeNaissancePicker.) {
            self.present(Alert.makeAlert(titre: "Erreur", message: "Veuillez saisir votre date de naissance"), animated: true)
            return
        }*/
        
        
        //utilisateur?.idPhoto = ""
        utilisateur?.score = 0
        utilisateur?.bio = ""
        utilisateur?.nom = nomTextField.text
        utilisateur?.prenom = prenomTextField.text
        //utilisateur?.dateNaissance = dateDeNaissancePicker.date
        
        if (sexeChooser.selectedSegmentIndex == 1 ){
            utilisateur?.sexe = true
        } else if (sexeChooser.selectedSegmentIndex == 2){
            utilisateur?.sexe = false
        }
        
        
        UtilisateurViewModel().manipulerUtilisateur(utilisateur: utilisateur!,methode: .put, completed: { (success) in
            // STOP Spinner
            
            if success {
                self.present(Alert.makeAlert(titre: "Succes", message: "Profil modifié"),animated: true)
                self.initializePage()
            } else {
                
            }
        })
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
        
        uploadImage.image = image
    }
    
    
}
