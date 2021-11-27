//
//  MdpOublieView.swift
//  Chicky
//
//  Created by Jamel & Maher on 27/11/2021.
//

import UIKit

class MdpOublieView: UIViewController {
    
    // VAR
    struct MotDePasseOublieData {
        var email: String?
        var code: String?
    }
    
    var data : MotDePasseOublieData?
    let spinner = SpinnerViewController()
    
    // WIDGET
    @IBOutlet weak var emailTextField: UITextField!
    
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ConfirmationView
        destination.data = data
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
    @IBAction func suivant(_ sender: Any) {
        
        if (emailTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Veuillez taper votre email"), animated: true)
            return
        }
        
        startSpinner()
        
        data = MotDePasseOublieData(email: emailTextField.text, code: String(Int.random(in: 100000..<999999)))
        
        UtilisateurViewModel().motDePasseOublie(email: (data?.email)!, codeDeReinit: (data?.code)! ) { success in
            self.stopSpinner()
            if success {
                self.performSegue(withIdentifier: "confirmationSegue", sender: self.data)
            } else {
                self.present(Alert.makeAlert(titre: "Erreur", message: "Email innexistant"), animated: true)
            }
        }
    }
    
}
