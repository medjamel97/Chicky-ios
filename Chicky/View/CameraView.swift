//
//  Camera.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class CameraView: UIViewController {

    // VAR
    typealias DownloadComplete = (Bool) -> ()
    let publicationModel = PublicationViewModel()
    
    // WIDGET
    @IBOutlet weak var idPhotoTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS
    
    
    // ACTIONS
    @IBAction func ajouterPublication(_ sender: Any) {
        let publication = Publication(_id: nil, idPhoto: idPhotoTextField.text, description: descriptionTextField.text, date: Date())
        
        publicationModel.manipulerPublication(publication: publication, methode: .post, completed: { (success) in
            
            if success {
                self.present(Alert.makeAlert(titre: "Succés", message: "Publication crée avec succés"), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Succés", message: "Erreur d'ajout de publication"), animated: true)
            }
        
        })
    }
}
