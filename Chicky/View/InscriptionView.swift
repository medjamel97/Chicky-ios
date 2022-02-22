//
//  Inscription.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class InscriptionView: UIViewController {
    
    // VAR
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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
            makeAlert(titre: "Warning", message: "Please type your username")
            return
        }
        
        if (emailTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your email")
            return
        }else if (emailTextField.text?.contains("@") == false){
            makeAlert(titre: "Warning", message: "Please type your email correctly")
            return
        }
        
        if (motDePasseTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your password")
            return
        }
        
        if (confirmationMotDePasseTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type the password confirmation")
            return
        }
        
        if (motDePasseTextField.text != confirmationMotDePasseTextField.text) {
            makeAlert(titre: "Warning", message: "Password and confirmation don't match")
            return
        }
        
        utilisateur.pseudo = pseudoTextField.text
        utilisateur.email = emailTextField.text
        utilisateur.mdp = motDePasseTextField.text
        
        performSegue(withIdentifier: "inscriptionSuivantSegue", sender: utilisateur)
    }
    
    @IBAction func redirectionConnexion(_ sender: UIButton) {
    }
}
