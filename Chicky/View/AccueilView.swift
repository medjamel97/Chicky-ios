//
//  Accueil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class AccueilView: UIViewController {

    // VAR
    var liked = false
    
    // WIDGET
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var publicationImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLayout()
    }
    
    // METHODS
    func setupLayout() {
        PublicationViewModel().getAllPublications { success, publications in
            if success {
                for publication in publications! {
                    self.descriptionLabel.text = publication.description
                }
            } else {
                
            }
        }
    }
    
    // ACTIONS
    @IBAction func likeAction(_ sender: Any) {
        
        if (liked) {
            likeButton.setImage(UIImage(named: "icon-favorites"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "icon-favorites-filled"), for: .normal)
        }
        
        liked = !liked
    }

}
