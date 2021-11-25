//
//  Inscription.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import GoogleSignIn

class InscriptionView: UIViewController {
    
    // VAR
    let signInConfig = GIDConfiguration.init(clientID: "1068988633012-o3ncrfkpu7veivr731s4lco8ok11fl47.apps.googleusercontent.com")
    var pseudo: String?
    var motDePasse: String?
    var currentUser: Bool?
    var utilisateurViewModel = UtilisateurViewModel()
    var utilisateur = Utilisateur()
    
    // WIDGET
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var motDePasseTextField: UITextField!
    @IBOutlet weak var confirmationMotDePasseTextField: UITextField!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inscriptionSuivantSegue" {
            let destination = segue.destination as! InscriptionSuivantView
            destination.utilisateur = utilisateur
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS
    func makeAlert(titre: String?, message: String?) {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    // ACTIONS
    @IBAction func inscription(_ sender: UIButton) {
        
        if (pseudoTextField.text == "") {
            makeAlert(titre: "Erreur", message: "Veuillez saisir votre pseudo")
            return
        }
        
        if (emailTextField.text == "") {
            makeAlert(titre: "Erreur", message: "Veuillez saisir votre email")
            return
        }
        
        if (motDePasseTextField.text == "") {
            makeAlert(titre: "Erreur", message: "Veuillez saisir votre mot de passe")
            return
        }
        
        if (confirmationMotDePasseTextField.text == "") {
            makeAlert(titre: "Erreur", message: "Veuillez confirmer le mot de passe")
            return
        }
        
        if (motDePasseTextField.text != confirmationMotDePasseTextField.text) {
            makeAlert(titre: "Erreur", message: "Le mot de passe et different de la confirmation")
            return
        }
        
        utilisateur.pseudo = pseudoTextField.text
        utilisateur.email = emailTextField.text
        utilisateur.mdp = motDePasseTextField.text
        
        performSegue(withIdentifier: "inscriptionSuivantSegue", sender: utilisateur)
    }
    
    @IBAction func inscriptiongoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            let emailAddress = user.profile?.email
        }
    }
    
    
    @IBAction func redirectionConnexion(_ sender: UIButton) {
    }
}
