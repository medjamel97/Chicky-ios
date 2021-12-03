//
//  LaunchScreenView.swift
//  iProceed
//
//  Created by Mac-Mini_2021 on 28/11/2021.
//

import Foundation
import UIKit

class VerifCompteView: UIViewController {
    
    // variables
    var utilisateur : Utilisateur?
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spinner = SpinnerViewController()
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        /*let loginManager = LoginManager()
        loginManager.logOut()*/
        
        checkUtilisateur()
    }
    
    func checkUtilisateur(){
        
        let token = UserDefaults.standard.string(forKey: "tokenConnexion")

        if token != nil {
            print(token)
            UtilisateurViewModel().recupererUtilisateurParToken(userToken: token!) { success, utilisateur in
                if success {
                    self.performSegue(withIdentifier: "redirectAccueil", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "redirectConnexion", sender: nil)
                }
            }
        } else {
            print("saret nul")
            self.performSegue(withIdentifier: "redirectConnexion", sender: nil)
        }
    }
}
