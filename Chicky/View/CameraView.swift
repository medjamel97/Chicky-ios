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
       
    }
}
