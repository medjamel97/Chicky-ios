//
//  ConfirmationView.swift
//  Chicky
//
//  Created by Jamel & Maher on 27/11/2021.
//

import UIKit

class ConfirmationView: UIViewController {
    
    // VAR
    var data : MdpOublieView.MotDePasseOublieData?
    var compteur: Int?
    var compteurTimer : Timer?
    
    // WIDGET
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var compteurExpirationLabel: UILabel!
    @IBOutlet weak var buttonSend: UIButton!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ChangerMdpView
        destination.email = data?.email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compteurExpirationLabel.text = "60"
        compteur = 60
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    // METHODS
    func startTimer () {
        guard compteurTimer == nil else { return }
        
        compteurTimer =  Timer.scheduledTimer(
            timeInterval: 1,
            target      : self,
            selector    : #selector(update),
            userInfo    : nil,
            repeats     : true)
    }
    
    func stopTimer() {
        compteurTimer?.invalidate()
        compteurTimer = nil
    }
    
    @objc
    func update()  {
        if (compteur! > 0){
            compteur! -= 1
            compteurExpirationLabel.text = String(compteur!)
        } else {
            stopTimer()
            buttonSend.isEnabled = false
            codeTextField.isUserInteractionEnabled = false
            compteurExpirationLabel.textColor = .darkGray
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Le code a exprié veuillez recommencer"), animated: true)
        }
    }
    
    // ACTIONS
    @IBAction func suivant(_ sender: Any) {
        
        if (codeTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Veuillez taper le code"), animated: true)
            return
        }
        
        if (codeTextField.text == data?.code ) {
            self.performSegue(withIdentifier: "changerMdpSegue", sender: data?.email)
        } else {
            self.present(Alert.makeAlert(titre: "Erreur", message: "Code incorrect"), animated: true)
        }
    }
    
}
