//
//  InscriptionSuivantView.swift
//  Chicky
//
//  Created by Jamel & Maher on 22/11/2021.
//

import UIKit

class InscriptionSuivantView: UIViewController {
    
    // VAR
    var utilisateur: Utilisateur?
    var sexe: String?
    
    // WIDGET
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var dateDeNaissancePicker: UIDatePicker!
    @IBOutlet weak var imageTelecharge: UIImageView!
    @IBOutlet weak var sexeChooser: UISegmentedControl!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ConnexionView
        destination.email = sender as? String
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
    }
    
    // METHODS
    func goToLogin(email: String?) {
        self.performSegue(withIdentifier: "connexionSegue", sender: email)
    }
    
    // ACTIONS
    @IBAction func radioMale(sender: AnyObject) {
        sexe = "Male"
    }
    
    @IBAction func radioFemale(sender: AnyObject) {
        sexe = "Female"
    }
    
    @IBAction func inscriptionButton(_ sender: Any) {
        
        if (nomTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your firstname"), animated: true)
            return
        }
        
        if (prenomTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your lastname"), animated: true)
            return
        }
        
        if (sexeChooser.selectedSegmentIndex == 0 ){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please choose your gender"), animated: true)
            return
        }
        
        utilisateur?.idPhoto = ""
        utilisateur?.score = 0
        utilisateur?.bio = ""
        utilisateur?.nom = nomTextField.text
        utilisateur?.prenom = prenomTextField.text
        utilisateur?.dateNaissance = dateDeNaissancePicker.date
        
        if (sexeChooser.selectedSegmentIndex == 1 ){
            utilisateur?.sexe = true
        } else {
            utilisateur?.sexe = false
        }
        
        // START Spinnder
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        UtilisateurViewModel().inscription(utilisateur: utilisateur!, completed: { (success) in
            // STOP Spinner
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
            
            if success {
                
                let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    self.goToLogin(email: self.utilisateur?.email)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
            }
            
            // STOP Spinner
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        })
    }
}
