//
//  CommentairesView.swift
//  Chicky
//
//  Created by Apple Mac on 13/12/2021.
//

import Foundation
import UIKit

class CommentairesView: UIViewController {
    
    // VARS
    var publication: Publication?
    var commentaires: [Commentaire] = []
    
    // WIDGETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nouveauCommentaireTextField: UITextField!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentaires.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        
        let imageProfile = contentView?.viewWithTag(1) as! UIImageView
        let labelUsername = contentView?.viewWithTag(2) as! UILabel
        let labelCommentaire = contentView?.viewWithTag(3) as! UILabel
        
        let commentaire = commentaires[indexPath.row]
        
        //imageProfile.image = commentaire.utilisateur.idPhoto
        labelUsername.text = (commentaire.utilisateur?.prenom)! + " " + (commentaire.utilisateur?.nom)!
        labelCommentaire.text = commentaire.description
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            /*CommentaireViewModel().supprimerCommentaire(_id: commentaires[indexPath.row]._id) { success in
             if success {
             print("deleted chat")
             self.commentaires.remove(at: indexPath.row)
             tableView.reloadData()
             } else {
             print("error while deleting chat")
             }
             }*/
        }
    }
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recupererCommentaires()
    }
    
    // METHODS
    func recupererCommentaires() {
        
        CommentaireViewModel().recupererCommentaireParPublication(idPublication: publication?._id) { success, commentairesfromRep in
            if success {
                self.commentaires = commentairesfromRep!
                self.tableView.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Erreur", message: "Internal server error"), animated: true)
            }
        }
    }
    
    // ACTIONS
    @IBAction func envoyerCommentaire(_ sender: Any) {
        if nouveauCommentaireTextField.text!.isEmpty {
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Veuillez saisir une description"), animated: true)
            return
        }
        CommentaireViewModel().ajouterCommentaire(idPublication: (publication?._id)!, commentaire: Commentaire(description: nouveauCommentaireTextField.text, date: Date())) { success in
            if success {
                self.recupererCommentaires()
            } else {
                self.present(Alert.makeServerErrorAlert(), animated: true)
            }
        }
        nouveauCommentaireTextField.text = ""
    }
    
}
