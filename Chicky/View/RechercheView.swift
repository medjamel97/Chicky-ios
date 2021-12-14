//
//  Recherche.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class RechercheView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {
    
    
    // VARS
    let searchController = UISearchController()
    var utilisateurAux : [Utilisateur] = []
    var publicationAux : [Publication] = []
    var publications : [Publication] = []
    var utilisateurs : [Utilisateur] = []
    
    // WIDGETS
    @IBOutlet weak var cvPosts: UICollectionView!
    @IBOutlet weak var cvPeople: UICollectionView!
    
    // PROTOCOLS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == cvPosts) {
            return publications.count
        } else if (collectionView == cvPeople) {
            return utilisateurs.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == cvPeople) {
            print("cv peoople")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pCell", for: indexPath) as! PeopleCollectionViewCell
            let contentView = cell.contentView
            
            let imageUtilisateur = contentView.viewWithTag(1) as! UIImageView
            let labelname = contentView.viewWithTag(2) as! UILabel
            
            imageUtilisateur.layer.cornerRadius = ROUNDED_RADIUS
            labelname.text = utilisateurs[indexPath.row].prenom
            
            ImageLoader.shared.loadImage(
                identifier: utilisateurs[indexPath.row].idPhoto!,
                url: Constantes.images + utilisateurs[indexPath.row].idPhoto!,
                completion: { [] image in
                    imageUtilisateur.image = image
                })
            
            return cell
        } else {
            print("cv posts")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PostsCollectionViewCell
            let contentView = cell.contentView
            
            let imagePublication = contentView.viewWithTag(1) as! UIImageView
            let labeldescription = contentView.viewWithTag(2) as! UILabel
            
            imagePublication.layer.cornerRadius = ROUNDED_RADIUS
            labeldescription.text = publications[indexPath.row].description
            print(publications[indexPath.row].idPhoto!)
            
            ImageLoader.shared.loadImage(
                identifier: publications[indexPath.row].idPhoto!,
                url: Constantes.images + publications[indexPath.row].idPhoto!,
                completion: { [] image in
                    imagePublication.image = image
                })
            
            return cell
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        publicationAux = publications
        utilisateurAux = utilisateurs
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        utilisateurs = []
        publications = []
        for publication in publicationAux {
            if publication.description!.lowercased().starts(with: searchText.lowercased()) {
                
                publications.append(publication)
            }
        }
        for user in utilisateurAux {
            if user.prenom!.lowercased().starts(with: searchText.lowercased()) {
                utilisateurs.append(user)
            }
        }
        
        cvPosts.reloadData()
        cvPeople.reloadData()
        
        if searchText == "" {
            publications = publicationAux
            utilisateurs = utilisateurAux
        }
    }
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializeHistory()
    }
    
    // METHODS
    func initializeHistory() {
        PublicationViewModel().recupererToutPublication{success, publicationsfromRep in
            if success {
                self.publications = publicationsfromRep!
                self.cvPosts.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)
            }
        }
        
        UtilisateurViewModel().getAllUtilisateurs{success, utilisateursFromRep in
            if success {
                self.utilisateurs = utilisateursFromRep!
                self.cvPeople.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load users "),animated: true)
                
            }
        }
    }
    
    // ACTIONS
    
}

