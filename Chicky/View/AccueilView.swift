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
        
<<<<<<< HEAD
        publicationViewModel.getPublications(completed: { (success,publications) in
=======
        publicationViewModel.recupererPublication(completed: { (success) in
>>>>>>> Maher
            
            if success {
                
                for publication in publications! {
                    self.descriptionLabel.text = publication.description
                }
            } else {
                print("error")
            }
        
        })
<<<<<<< HEAD
        //descriptionLabel.text = "619fbdd3ac8260d0fecf8881"
=======
        descriptionLabel.text = "619fbdd3ac8260d0fecf8881"
>>>>>>> Maher
    }
    
    override func viewDidAppear(_ animated: Bool) {
        publicationViewModel.getPublications(completed: { (success,publications) in
            
            if success {
                
                for publication in publications! {
                    self.descriptionLabel.text = publication.description
                }
            } else {
                print("error")
            }
        
        })
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
