//
//  LaunchScreenView.swift
//  iProceed
//
//  Created by Mac-Mini_2021 on 28/11/2021.
//

import Foundation
import UIKit

class VerifAccountView: UIViewController {
    
    // variables
    var user : User?
    
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
        
        checkUser()
    }
    
    func checkUser(){
        
        let token = UserDefaults.standard.string(forKey: "userToken")
        
        if token != nil {
            UtilisateurViewModel().getUserFromToken(userToken: token!) { success, user in
                if success {
                    
                    self.performSegue(withIdentifier: "redirectAccueil", sender: nil)
                    
                } else {
                    self.performSegue(withIdentifier: "notLoggedInSegue", sender: nil)
                }
            }
        } else {
            self.performSegue(withIdentifier: "redirectConnexion", sender: nil)
        }
    }
}
