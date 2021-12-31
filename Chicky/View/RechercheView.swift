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
    
    var utilisateursAux : [Utilisateur] = []
    var publicationsAux : [Publication] = []
    var musiquesAux : [Musique] = []
    
    var publications : [Publication] = []
    var utilisateurs : [Utilisateur] = []
    var musiques : [Musique] = []
    
    var selectedPublication : Publication?
    var selectedUtilisateur : Utilisateur?
    var selectedMusic : Musique?
    
    // WIDGETS
    @IBOutlet weak var cvPosts: UICollectionView!
    @IBOutlet weak var cvPeople: UICollectionView!
    @IBOutlet weak var cvMusique: UICollectionView!
    
    // PROTOCOLS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == cvPosts) {
            return publications.count
        } else if (collectionView == cvPeople) {
            return utilisateurs.count
        } else if (collectionView == cvMusique) {
            return musiques.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvPeople {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pCell", for: indexPath)
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
        } else if collectionView == cvPosts {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
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
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "musicPlayerSegue" {
            let destination = segue.destination as! MusiqueView
            destination.currentMusic = selectedMusic
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "musicPlayerSegue", sender: selectedMusic)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        publicationsAux = publications
        utilisateursAux = utilisateurs
        musiquesAux = musiques
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        utilisateurs = []
        publications = []
        musiques = []
        
        for publication in publicationsAux {
            if publication.description!.lowercased().starts(with: searchText.lowercased()) {
                
                publications.append(publication)
            }
        }
        
        for user in utilisateursAux {
            if user.prenom!.lowercased().starts(with: searchText.lowercased()) {
                utilisateurs.append(user)
            }
        }
        
        for musique in musiques {
            if musique.titre.lowercased().starts(with: searchText.lowercased()) || musique.artiste.lowercased().starts(with: searchText.lowercased()) {
                musiques.append(musique)
            }
        }
        
        cvPosts.reloadData()
        cvPeople.reloadData()
        
        if searchText == "" {
            publications = publicationsAux
            utilisateurs = utilisateursAux
            musiques = musiquesAux
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
        PublicationViewModel.sharedInstance.recupererToutPublication{success, publicationsfromRep in
            if success {
                self.publications = publicationsfromRep!
                self.cvPosts.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)
            }
        }
        
        UtilisateurViewModel.sharedInstance.recupererToutUtilisateur {success, utilisateursFromRep in
            if success {
                self.utilisateurs = utilisateursFromRep!
                self.cvPeople.reloadData()
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load users "),animated: true)
            }
        }
        
        MusiqueViewModel.sharedInstance.recupererTout {success, musiquesFromRep in
            if success {
                self.musiques = musiquesFromRep!
                self.cvMusique.reloadData()
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load musiques "),animated: true)
            }
        }
    }
    
    // ACTIONS
    
}

