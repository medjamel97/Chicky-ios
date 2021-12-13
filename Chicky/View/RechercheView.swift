//
//  Recherche.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class RechercheView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var cvPosts: UICollectionView!
    
    @IBOutlet weak var cvPeople: UICollectionView!
     
    let searchController = UISearchController()
    
    // VARS
    private var publications : [Publication] = []
    private var utilisateurs : [Utilisateur] = []
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == cvPosts) {
            return publications.count
        }
        return utilisateurs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
      
                
          if (collectionView == cvPeople) {
              print("cv peoople")
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "pCell", for: indexPath) as! PeopleCollectionViewCell
            let contentView = cell2.contentView
            
            
            let labelname = contentView.viewWithTag(2) as! UILabel
            let imageUtilisateur = contentView.viewWithTag(1) as! UIImageView
            
            //labelname.text = utilisateurs[indexPath.row].nom! + " " + utilisateurs[indexPath.row].prenom!
        //     imageCategorie.image = UIImage(named: scategorie[indexPath.row])
              //print(utilisateurs[indexPath.row].idPhoto!)
                       labelname.text = utilisateurs[indexPath.row].prenom
              imageUtilisateur.image = UIImage(named: "Cafe")
             //          identifier: utilisateurs[indexPath.row].idPhoto!,
             /*   url: Constantes.images + utilisateurs[indexPath.row].idPhoto!,
                completion: { [] image in
                    imageUtilisateur.image = image
                })*/
            return cell2
            
          } else {
              print("cv posts")
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PostsCollectionViewCell
              let contentView = cell.contentView
              
              
              let labeldescription = contentView.viewWithTag(2) as! UILabel
              let imagePublication = contentView.viewWithTag(1) as! UIImageView
              
              labeldescription.text = publications[indexPath.row].description
          //     imageCategorie.image = UIImage(named: categorie[indexPath.row])
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
    

      
        
        // WIDGETS
     
        
     
    
    // PROTOCOLS
       
    var publicationAux : [Publication] = []
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        publicationAux = publications
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        publications = []
       for publication in publicationAux {
            if (publication.description) == searchText{

                publications.append(publication)
            }
        }
        
        
        cvPosts.reloadData()
        
        if searchText == "" {
            publications = publicationAux
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
            
            PublicationViewModel().getAllPublications{success, publicationsfromRep in
                if success {
                    self.publications = publicationsfromRep!
                   // self.tableView.reloadData()
                  //  self.cvPosts.reloadData()
                    self.cvPosts.reloadData()
                    //self.coll
                
                }else {
                    self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)

                }
            }
     
            UtilisateurViewModel().getAllUtilisateurs{success, utilisateur in
                if success {
                    self.utilisateurs = utilisateur!
                
                    self.cvPeople.reloadData()
                    //self.coll
                
                }else {
                    self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)

                }
            }
            
            
            
            
        }
    

    
    
    
        
        // ACTIONS
        
    }

