//
//  Musique.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class MusiqueView: UIViewController {

    // VAR
    var currentMusic: Musique?
    
    @IBOutlet weak var titreMusiqueLabel: UILabel!
    @IBOutlet weak var artisteMusiqueLabel: UILabel!
    // WIDGET
    
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titreMusiqueLabel.text = currentMusic?.titre
        artisteMusiqueLabel.text = currentMusic?.artiste
    }
    
    
    
    // METHODS
    
    
    // ACTIONS
    @IBOutlet weak var playMusic: UIImageView!
    

}
