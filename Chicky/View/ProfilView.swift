//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ProfilView: UIViewController {
    
    // VAR
    var utilisateurViewModel = UtilisateurViewModel()
    var utilisateur: Utilisateur?
    
    // WIDGET
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nomPrenomTF: UILabel!
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true

        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 5.0
        
        initializeProfile()
    }
    
    // METHODS
    func initializeProfile(){
        UtilisateurViewModel().recupererUtilisateurParToken(userToken: UserDefaults.standard.string(forKey: "tokenConnexion")!) { [self] success, result in
            self.utilisateur = result
            
            nomPrenomTF.text = (result?.prenom)! + " " + (result?.nom)!
            usernameLabel.text = "@" + (utilisateur?.pseudo)!
            
            ImageLoader.shared.loadImage(identifier: (utilisateur?.idPhoto)!, url: Constantes.images + (utilisateur?.idPhoto)!) { imageResp in
                
                profileImage.image = imageResp
            }
        }
    }
    
    
    // ACTIONS
    @IBAction func deconnexion(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "tokenConnexion")
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
}
