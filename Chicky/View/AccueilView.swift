//
//  Accueil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class AccueilView: UIViewController {

    let publicationViewModel = PublicationViewModel()
    
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
        
        publicationImage.image = UIImage(named: "619fbdd3ac8260d0fecf8881")
        
        publicationViewModel.recupererPublication(completed: { (success) in
            
            if success {
                print("created")
            } else {
                print("error")
            }
        
        })
        descriptionLabel.text = "619fbdd3ac8260d0fecf8881"
    }
    
    // METHODS
    func setupLayout() {
        
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
