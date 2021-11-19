//
//  Connexion.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import Alamofire

class ConnexionView: UIViewController {
    
    // VAR
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
        
    }
}
