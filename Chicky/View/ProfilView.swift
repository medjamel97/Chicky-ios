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
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // let destination = segue.destination as! ModifierProfilView
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeProfile()
    }
    
    // METHODS
    func initializeProfile(){
        //UserDefaults.
        //utilisateurViewModel.recupererUtilisateurParID(_id: "")
        usernameLabel
    }
    
    
    // ACTIONS
    @IBAction func modifierProfil(_ sender: Any) {
        performSegue(withIdentifier: "modifierProfilSegue", sender: utilisateur)
    }
    
    @IBAction func deconnexion(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "tokenConnexion")
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
}
