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
    let signInConfig = GIDConfiguration	.init(clientID: "1068988633012-o3ncrfkpu7veivr731s4lco8ok11fl47.apps.googleusercontent.com")
    let utilisateurViewModel = UtilisateurViewModel()
    var pseudo: String?
    var motDePasse: String?
    var currentUser: Bool?
    
    // WIDGET
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var motDePasseTextField: UITextField!
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS
    
    // ACTIONS
    @IBAction func connexion(_ sender: Any) {
        // START Spinnder
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        AF.request(Constantes.host + "/utilisateur").responseJSON(completionHandler: { response in
            print(response)
            self.performSegue(withIdentifier: "connexionSegue", sender: nil)
            
            
            // STOP Spinner
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        })
    }
    
    @IBAction func connexionGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            let emailAddress = user.profile?.email
            
            // If sign in succeeded, display the app's main content View.
        }
    }
}
