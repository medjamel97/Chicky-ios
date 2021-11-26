//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ModifierProfilView: UIViewController {
    
    // VAR
    var nom: String?
    var prenom : String?
    
    // WIDGET
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePage()
    }
    
    // METHODS
    func initializePage() {
        nomTextField.text = nom
    }
    
    // ACTIONS
    @IBAction func modifierProfil(_ sender: Any) {
    }
    
    @IBAction func radioMale(sender: AnyObject) {
        print("Gender is Male")
    }
    
    @IBAction func radioFemale(sender: AnyObject) {
       print("Gender is Female")
    }
}
