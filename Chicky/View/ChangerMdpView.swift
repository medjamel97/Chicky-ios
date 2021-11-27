//
//  ChangerMdpView.swift
//  Chicky
//
//  Created by Jamel & Maher on 27/11/2021.
//

import UIKit

class ChangerMdpView: UIViewController {
    
    // VAR
    var email: String?
    let spinner = SpinnerViewController()
    
    // WIDGET
    @IBOutlet weak var motDePasseTextField: UITextField!
    @IBOutlet weak var confirmationMotDePasseTextField: UITextField!
    
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ConnexionView
        destination.email = self.email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS
    func startSpinner() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func stopSpinner() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    
    // ACTIONS
    @IBAction func Terminer(_ sender: Any) {
        
        if (motDePasseTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Vous devez taper votre nouveau mot de passe"), animated: true)
            return
        }
        
        if (confirmationMotDePasseTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Vous devez taper la confirmation de votre nouveau mot de passe"), animated: true)
            return
        }
        
        if (motDePasseTextField.text != confirmationMotDePasseTextField.text) {
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Mot de passe et confirmation doivent etre identique"), animated: true)
            return
        }
        
        startSpinner()
        
        UtilisateurViewModel().changerMotDePasse(email: email!, nouveauMotDePasse: confirmationMotDePasseTextField.text! , completed: { success in
            self.stopSpinner()
            if success {
                let action = UIAlertAction(title: "Retour", style: .default) { UIAlertAction in
                    self.performSegue(withIdentifier: "revenirConnexionSegue", sender: nil)
                }
                self.present(Alert.makeSingleActionAlert(titre: "Félicitation", message: "Votre mot de passe a été changé", action: action), animated: true)
            }else{
                self.present(Alert.makeAlert(titre: "Erreur", message: "Echec de changement de mot de passe"), animated: true)
            }
        })
    }
}
