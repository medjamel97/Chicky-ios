//
//  ViewController.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 08/11/2021.
//

import UIKit

class ChoisirUtilisateurView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // VARS
    private var utilisateurs : [Utilisateur] = []
    
    // WIDGETS
    @IBOutlet weak var tableView: UITableView!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilisateurs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let contentView = cell?.contentView

        let imageProfile = contentView?.viewWithTag(1) as! UIImageView
        let labelName = contentView?.viewWithTag(2) as! UILabel
        let labelUsername = contentView?.viewWithTag(3) as! UILabel
        
        let utilisateur = utilisateurs[indexPath.row]
        
        labelName.text = utilisateur.prenom! + " " + utilisateur.nom!
        labelUsername.text = "@" + utilisateur.pseudo!
        
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.clipsToBounds = true
        imageProfile.layer.borderColor = UIColor.white.cgColor
        imageProfile.layer.borderWidth = 5.0
        ImageLoader.shared.loadImage(
            identifier: utilisateur.idPhoto!,
            url: IMAGE_URL + utilisateur.idPhoto!,
            completion: { [] image in
                imageProfile.image = image
            })
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MessagerieViewModel.sharedInstance.creerNouvelleConversation(recepteur: utilisateurs[indexPath.row]._id!) { success, Conversation in
            if (success) {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.present(Alert.makeServerErrorAlert(), animated: true)
            }
        }
    }
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    // METHODS
    func initialize() {
        UtilisateurViewModel.sharedInstance.recupererToutUtilisateur() { success, utilisateursfromRep in
            if success {
                self.utilisateurs = []
                
                for utilisateur in utilisateursfromRep! {
                    if utilisateur._id != UserDefaults.standard.string(forKey: "idUtilisateur"){
                        
                            self.utilisateurs.append(utilisateur)
                    }
                }
                
                self.tableView.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load utilisateurs "),animated: true)

            }
        }
    }
}

