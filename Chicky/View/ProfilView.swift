//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ProfilView: UIViewController, ModalTransitionListener {
  
    
    // VAR
    var profileOfSomeoneElse: Utilisateur?
    var publications: [Publication] = []
    var utilisateurViewModel = UtilisateurViewModel()
    
    // WIDGET
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nomPrenomTF: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var dateNaissLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    //@IBOutlet weak var darkThemeIcon: UIImageView!
    //@IBOutlet weak var darkThemeSwitch: UISwitch!
    
    // PROTOCOLS
    
    // LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModalTransitionMediator.instance.setListener(listener: self)
        
        editProfileButton.isHidden = true
        logoutButton.isHidden = true
        //darkThemeIcon.isHidden = true
        //darkThemeSwitch.isHidden = true
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 5.0
        
        if profileOfSomeoneElse == nil {
            initializeProfileMy()
        } else {
            initializeProfileOfSomeoneElse()
        }
    }
    
    func popoverDismissed() {
        
        editProfileButton.isHidden = true
        logoutButton.isHidden = true
        
        if profileOfSomeoneElse == nil {
            initializeProfileMy()
        } else {
            initializeProfileOfSomeoneElse()
        }
    }
    
    
    // METHODS
    func initializeProfileMy(){
        UtilisateurViewModel().recupererUtilisateurParToken(userToken: UserDefaults.standard.string(forKey: "tokenConnexion")!) { [self] success, result in
            if success {
                let utilisateur = result
                
                editProfileButton.isHidden = false
                logoutButton.isHidden = false
                //darkThemeIcon.isHidden = false
               // darkThemeSwitch.isHidden = false
                
                dateNaissLabel.text = "Born in " +  DateUtils.formatFromDateForDisplayYearMonthDay(date: (utilisateur?.dateNaissance)!)
                if utilisateur?.sexe == true {
                    genderLabel.text = "Gender : Male"
                } else {
                    genderLabel.text = "Gender : Female"
                }
                
                nomPrenomTF.text = (result?.prenom)! + " " + (result?.nom)!
                
                if utilisateur?.pseudo == "" {
                    usernameLabel.text = (utilisateur?.nom)! + "_" + (utilisateur?.prenom)!
                } else {
                    usernameLabel.text = (utilisateur?.pseudo)!
                }
                
                ImageLoader.shared.loadImage(identifier: (utilisateur?.idPhoto)!, url: IMAGE_URL + (utilisateur?.idPhoto)!) { imageResp in
                    
                    profileImage.image = imageResp
                }
                
            } else {
                
            }
            
        }
    }
    
    func initializeProfileOfSomeoneElse(){
        
        let utilisateur = profileOfSomeoneElse!
        
        nomPrenomTF.text = utilisateur.prenom! + " " + utilisateur.nom!
        dateNaissLabel.text = "Born in " + DateUtils.formatFromDateForDisplayYearMonthDay(date: (utilisateur.dateNaissance)!)
        
        
        if utilisateur.sexe == true {
            genderLabel.text = "Male"
        } else {
            genderLabel.text = "Female"
        }
        
        
        if utilisateur.pseudo == "" {
            usernameLabel.text = "@" + utilisateur.nom! + "_" + utilisateur.prenom!
        } else {
            usernameLabel.text = "@" + utilisateur.pseudo!
        }
        
        ImageLoader.shared.loadImage(identifier: utilisateur.idPhoto!, url: IMAGE_URL + utilisateur.idPhoto!) { [self] imageResp in
            
            profileImage.image = imageResp
        }
    }
    
    // ACTIONS
    @IBAction func switchTheme(_ sender: UISwitch) {
        if sender.isOn {
            /*UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }*/
        } else {
            /*UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }*/
        }
    }
    
    @IBAction func deconnexion(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "tokenConnexion")
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
}
