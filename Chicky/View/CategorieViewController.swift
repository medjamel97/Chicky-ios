//
//  CategorieViewController.swift
//  Chicky
//
//  Created by Jamel & Maher on 8/12/2021.
//

import UIKit

class CategorieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    

    
    private var categorie : [String] = ["Cafe","University","Hotel","Bar","FitnessCenter","Airport"]
    var cat : String = "" 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categorie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        
        let imageCategorie = contentView?.viewWithTag(2) as! UIImageView
        let labelCategorie = contentView?.viewWithTag(1) as! UILabel
        //let labellastMessage = contentView?.viewWithTag(3) as! UILabel
      
        
        imageCategorie.image = UIImage(named: categorie[indexPath.row])
        labelCategorie.text = categorie[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          cat = categorie[indexPath.row]
      
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // let destination = segue.destination as! InscriptionSuivantView
      //  destination.utilisateur = utilisateur
        let destination = segue.destination as! SocialView
        destination.search = cat
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 

}
