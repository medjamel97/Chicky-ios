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
    @IBOutlet weak var idPostTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS
    
    
    // ACTIONS
    @IBAction func ajouterPublication(_ sender: Any) {
        let publication = Publication(_id: nil, idPhoto: idPostTextField.text, description: descriptionTextField.text, date: Date())
        
        publicationModel.manipulerPublication(publication: publication, methode: .post, completed: { (success) in
            
            if success {
                print("created")
            } else {
                print("error")
            }
        
        })
    }
}
