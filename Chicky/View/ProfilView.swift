//
//  Profil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class ProfilView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ModalTransitionListener {
  
    
    // VAR
    var profileOfSomeoneElse: Utilisateur?
    var publications: [Publication] = []
    var utilisateurViewModel = UtilisateurViewModel()
    
    // WIDGET
    @IBOutlet weak var postsCollectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nomPrenomTF: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var dateNaissLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
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
     //   print(publications[indexPath.row].idPhoto!)
        
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
        
        ModalTransitionMediator.instance.setListener(listener: self)
        
        settingsButton.isHidden = true
        editProfileButton.isHidden = true
        logoutButton.isHidden = true
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 5.0
        
        if profileOfSomeoneElse == nil {
            initializeProfileMy()
        } else {
            initializeProfileOfSomeoneElse()
        }
    }
    
    func popoverDismissed() {
        
        settingsButton.isHidden = true
        editProfileButton.isHidden = true
        logoutButton.isHidden = true
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 5.0
        
        if profileOfSomeoneElse == nil {
            initializeProfileMy()
        } else {
            initializeProfileOfSomeoneElse()
        }
    }
    
    
    // METHODS
    func initializeProfileMy(){
        UtilisateurViewModel().recupererUtilisateurParToken(userToken: UserDefaults.standard.string(forKey: "tokenConnexion")!) { [self] success, result in
            let utilisateur = result
            
            settingsButton.isHidden = false
            editProfileButton.isHidden = false
            logoutButton.isHidden = false
            
            dateNaissLabel.text = "Born in " +  DateUtils.formatFromDateForDisplayYearMonthDay(date: (utilisateur?.dateNaissance)!)
            if utilisateur?.sexe == true {
                genderLabel.text = "Gender : Male"
            } else {
                genderLabel.text = "Gender : Female"
            }
            
            nomPrenomTF.text = (result?.prenom)! + " " + (result?.nom)!
            
            if utilisateur?.pseudo == "" {
                usernameLabel.text = "@" + (utilisateur?.nom)! + "_" + (utilisateur?.prenom)!
            } else {
                usernameLabel.text = "@" + (utilisateur?.pseudo)!
            }
            
            ImageLoader.shared.loadImage(identifier: (utilisateur?.idPhoto)!, url: IMAGE_URL + (utilisateur?.idPhoto)!) { imageResp in
                
                profileImage.image = imageResp
            }
            
            initializePosts(idUser: UserDefaults.standard.string(forKey: "idUtilisateur")!)
        }
    }
    
    func initializeProfileOfSomeoneElse(){
        
        let utilisateur = profileOfSomeoneElse!
        
        nomPrenomTF.text = utilisateur.prenom! + " " + utilisateur.nom!
        dateNaissLabel.text = "Born in " + DateUtils.formatFromDateForDisplayYearMonthDay(date: (utilisateur.dateNaissance)!)
        
        
        if utilisateur.sexe == true {
            genderLabel.text = "Male"
        } else {
            genderLabel.text = "Female"
        }
        
        
        if utilisateur.pseudo == "" {
            usernameLabel.text = "@" + utilisateur.nom! + "_" + utilisateur.prenom!
        } else {
            usernameLabel.text = "@" + utilisateur.pseudo!
        }
        
        ImageLoader.shared.loadImage(identifier: utilisateur.idPhoto!, url: IMAGE_URL + utilisateur.idPhoto!) { [self] imageResp in
            
            profileImage.image = imageResp
        }
        
        initializePosts(idUser: utilisateur._id!)
    }
    
    func initializePosts(idUser: String) {
        PublicationViewModel.sharedInstance.recupererPublicationParUtilisateur(idUtilisateur: idUser) { [self] success, mesPublications in
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
