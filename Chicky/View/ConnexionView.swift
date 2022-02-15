//
//  Connexion.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import Alamofire
import GoogleSignIn

class ConnexionView: UIViewController {
    
    // VAR
    let signInConfig = GIDConfiguration.init(clientID: "129859709709-ji8he9ntqhetpgtmuj4a6hmdgd40s4eu.apps.googleusercontent.com")
    let googleLoginButton = GIDSignInButton()
    let utilisateurViewModel = UtilisateurViewModel()
    let spinner = SpinnerViewController()
    
    var email: String?
    
    // WIDGET
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var motDePasseTextField: UITextField!
    @IBOutlet weak var googleStackView: UIStackView!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.text = email
        googleStackView.addSubview(googleLoginButton)
        googleLoginButton.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        googleLoginButton.frame = CGRect(x:0 , y: 0, width: googleStackView.center.x, height: googleStackView.frame.height)
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
    
    func reEnvoyerEmail(email: String?) {
        utilisateurViewModel.reEnvoyerConfirmationEmail(email: email!, completed: { (success) in
            if success {
                self.present(Alert.makeAlert(titre: "Succés", message: "Email de confirmation envoyé a " + email!), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Erreur", message: "Echec d'envoi de l'email de confirmation"), animated: true)
            }
        })
    }
    
    // ACTIONS
    @IBAction func connexion(_ sender: Any) {
        
        if(emailTextField.text!.isEmpty || motDePasseTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Vous devez taper vos identifiants"), animated: true)
            return
        }
        
        startSpinner()
        
        utilisateurViewModel.connexion(email: emailTextField.text!, mdp: motDePasseTextField.text!,completed: { (success, reponse) in
            
            self.stopSpinner()
            
            if success {
                let utilisateur = reponse as! Utilisateur
                
                if utilisateur.isVerified! {
                    self.performSegue(withIdentifier: "connexionSegue", sender: nil)
                } else {
                    let action = UIAlertAction(title: "Réenvoyer", style: .default) { UIAlertAction in
                        self.reEnvoyerEmail(email: utilisateur.email)
                    }
                    self.present(Alert.makeActionAlert(titre: "Notice", message: "Cet email n'a pas été confirmé, Voulez vous re envoyer l'email de confirmation a " + utilisateur.email! + " ?", action: action),animated: true)
                    self.reEnvoyerEmail(email: utilisateur.email)
                }
            } else {
                self.present(Alert.makeAlert(titre: "Avertissement", message: "Email ou mot de passe incorrect."), animated: true)
            }
        })
    }
    
    @objc func googleSignIn() {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [self] user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            if user.profile != nil && user.profile?.givenName != nil && user.profile?.familyName != nil {
                loginWithSocialMedia(email: user.profile!.email, nom: user.profile!.familyName!, prenom: user.profile!.givenName!, socialMediaName: "Google")
            }
        }
    }
    
    func loginWithSocialMedia(email: String, nom: String, prenom: String, socialMediaName: String) {
        
        self.startSpinner()
        UtilisateurViewModel().loginWithSocialApp(email: email, nom: nom ,prenom: prenom, completed: { success, user in
            if success {
                self.performSegue(withIdentifier: "connexionSegue", sender: nil)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not login with " + socialMediaName), animated: true)
            }
            
            self.stopSpinner()
        })
    }
}
