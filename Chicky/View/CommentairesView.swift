//
//  CommentairesView.swift
//  Chicky
//
//  Created by Apple Mac on 13/12/2021.
//

import Foundation
import UIKit

class CommentairesView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        let editButton = contentView?.viewWithTag(4) as! UIButton
        let deleteButton = contentView?.viewWithTag(5) as! UIButton
        let newCommentTF = contentView?.viewWithTag(6) as! UITextField
        let checkButton = contentView?.viewWithTag(7) as! UIButton
        let crossButton = contentView?.viewWithTag(8) as! UIButton
        
        imageProfile.layer.cornerRadius = ROUNDED_RADIUS
        
        newCommentTF.isHidden = true
        checkButton.isHidden = true
        crossButton.isHidden = true
        
        
        var commentaire = commentaires[indexPath.row]
        
        if commentaires[indexPath.row].utilisateur?._id == UserDefaults.standard.string(forKey: "idUtilisateur") {
            
            editButton.addAction(UIAction(handler: { uiaction in
                labelCommentaire.isHidden = true
                editButton.isHidden = true
                deleteButton.isHidden = true
                newCommentTF.isHidden = false
                checkButton.isHidden = false
                crossButton.isHidden = false
                
                newCommentTF.text = commentaire.description
                
                
                checkButton.addAction(UIAction(handler: { uiaction in
                    if newCommentTF.text!.isEmpty {
                        self.present(Alert.makeAlert(titre: "Avertissement", message: "Description ne peut pas etre vide"),animated: true)
                        return
                    }
                    
                    
                    labelCommentaire.isHidden = false
                    editButton.isHidden = false
                    deleteButton.isHidden = false
                    newCommentTF.isHidden = true
                    checkButton.isHidden = true
                    crossButton.isHidden = true
                    
                    commentaire.description = newCommentTF.text
                    CommentaireViewModel().modifierCommentaire(commentaire: commentaire) { success in
                        if success {
                            print("Edited")
                            labelCommentaire.text = commentaire.description
                            
                        } else {
                            self.present(Alert.makeServerErrorAlert(),animated: true)
                        }
                    }
                }), for: .touchUpInside)
                
                crossButton.addAction(UIAction(handler: { uiaction in
                    labelCommentaire.isHidden = false
                    editButton.isHidden = false
                    deleteButton.isHidden = false
                    newCommentTF.isHidden = true
                    checkButton.isHidden = true
                    crossButton.isHidden = true
                }), for: .touchUpInside)
            }), for: .touchUpInside)
            
            deleteButton.addAction(UIAction(handler: { uiaction in
                self.present(Alert.makeActionAlert(titre: "Warning", message: "Are you sure you want to delete your comment", action: UIAlertAction(title: "Yes", style: .destructive, handler: { uiaction in
                    CommentaireViewModel().supprimerCommentaire(_id: commentaire._id) { success in
                        if success {
                            self.recupererCommentaires()
                        } else {
                            self.present(Alert.makeServerErrorAlert(),animated: true)
                        }
                    }
                })),animated: true)
            }), for: .touchUpInside)
            
        } else {
            editButton.isHidden = true
            deleteButton.isHidden = true
        }
        
        ImageLoader.shared.loadImage(identifier: (commentaire.utilisateur?.idPhoto!)!, url: Constantes.images + (commentaire.utilisateur?.idPhoto)!) { imageResp in
            
            imageProfile.image = imageResp
        }
        
        labelUsername.text = (commentaire.utilisateur?.prenom)! + " " + (commentaire.utilisateur?.nom)!
        labelCommentaire.text = commentaire.description
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            CommentaireViewModel().supprimerCommentaire(_id: commentaires[indexPath.row]._id) { success in
                if success {
                    print("deleted chat")
                    self.commentaires.remove(at: indexPath.row)
                    tableView.reloadData()
                } else {
                    print("error while deleting chat")
                }
            }
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
