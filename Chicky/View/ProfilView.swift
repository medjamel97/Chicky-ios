//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ProfilView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // VAR
    var publications: [Publication] = []
    var utilisateurViewModel = UtilisateurViewModel()
    var utilisateur: Utilisateur?
    
    // WIDGET
    @IBOutlet weak var postsCollectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nomPrenomTF: UILabel!
    
    // PROTOCOLS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return publications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        
        let imagePublication = contentView.viewWithTag(1) as! UIImageView
        let labeldescription = contentView.viewWithTag(2) as! UILabel
        
        imagePublication.layer.cornerRadius = ROUNDED_RADIUS
        labeldescription.text = publications[indexPath.row].description
        print(publications[indexPath.row].idPhoto!)
        
        ImageLoader.shared.loadImage(
            identifier: publications[indexPath.row].idPhoto!,
            url: IMAGE_URL + publications[indexPath.row].idPhoto!,
            completion: { [] image in
                imagePublication.image = image
            })
        
        return cell
    }
    
    // LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 5.0
        
        initializeProfile()
    }
    
    // METHODS
    func initializeProfile(){
        UtilisateurViewModel().recupererUtilisateurParToken(userToken: UserDefaults.standard.string(forKey: "tokenConnexion")!) { [self] success, result in
            self.utilisateur = result
            
            nomPrenomTF.text = (result?.prenom)! + " " + (result?.nom)!
            usernameLabel.text = "@" + (utilisateur?.pseudo)!
            
            ImageLoader.shared.loadImage(identifier: (utilisateur?.idPhoto)!, url: IMAGE_URL + (utilisateur?.idPhoto)!) { imageResp in
                
                profileImage.image = imageResp
            }
            
            initializePosts()
        }
    }
    
    func initializePosts() {
        PublicationViewModel.sharedInstance.recupererMesPublication { [self] success, mesPublications in
            publications = mesPublications!
            
            postsCollectionView.reloadData()
        }
    }
    
    // ACTIONS
    @IBAction func deconnexion(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "tokenConnexion")
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
}
