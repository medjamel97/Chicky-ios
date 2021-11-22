//
//  UtilisateurViewModel.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class UtilisateurViewModel: ObservableObject{
    
    init(){}
    
    typealias DownloadComplete = (Bool) -> ()
    
    func connexion(completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/utilisateur").responseJSON(completionHandler: { response in
            print(response)
            
            var success = true
                       
                       completed(success)
            
        })
    }
    
    func recupererUtilisateurParID(_id: Int?) -> Utilisateur {
        var data: Utilisateur?
        
        AF.request(Constantes.host + "/utilisateur",
                   method: .get,
                   parameters: ["_id": String(_id!)],
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseJSON(completionHandler: { jsonResponse in
                let jsonResponse = JSON(jsonResponse)[0]
                
                data = self.makeItem(jsonItem: jsonResponse)
            })
        
        return data!
    }
    
    func recupererToutUtilisateur() -> [Utilisateur] {
        var data: [Utilisateur]?
        
        AF.request(Constantes.host + "/utilisateur").responseJSON(completionHandler: { jsonResponse in
            let jsonResponse = JSON(jsonResponse)
            
            for (_,subJson):(String, JSON) in jsonResponse {
                data!.append(self.makeItem(jsonItem: subJson))
            }
        })
        
        return data!
    }
    
    func manipulerUtilisateur(utilisateur: Utilisateur, methode: HTTPMethod ) {
        
        AF.request(Constantes.host + "/utilisateur",
                   method: methode,
                   parameters: [
                    "_id" : utilisateur._id!,
                    "pseudo": utilisateur.pseudo!,
                    "email": utilisateur.email!,
                    "mdp": utilisateur.mdp!,
                    "nom": utilisateur.nom!,
                    "prenom": utilisateur.prenom!,
                    "dateNaissance": utilisateur.dateNaissance!,
                    "idPhoto": utilisateur.idPhoto!,
                    "sexe": utilisateur.sexe!,
                    "score": utilisateur.score!,
                    "bio": utilisateur.bio!
                   ],
                   encoding: JSONEncoding.default,
                   headers: nil)
            .response { response in
                print(response)
            }
    }
    
    func supprimerUtilisateur(utilisateur: Utilisateur) {
        
        AF.request(Constantes.host + "/utilisateur",
                   method: .delete,
                   parameters: ["_id": utilisateur._id!],
                   encoding: JSONEncoding.default,
                   headers: nil)
            .response { response in
                print(response)
            }
    }
    
    func makeItem(jsonItem: JSON) -> Utilisateur {
        Utilisateur(
            _id: jsonItem["_id"].stringValue,
            pseudo: jsonItem["pseudo"].stringValue,
            email: jsonItem["email"].stringValue,
            mdp: jsonItem["mdp"].stringValue,
            nom: jsonItem["nom"].stringValue,
            prenom: jsonItem["prenom"].stringValue,
            dateNaissance: Date(),
            idPhoto: jsonItem["idPhoto"].stringValue,
            sexe: jsonItem["sexe"].boolValue,
            score: jsonItem["score"].intValue,
            bio: jsonItem["bio"].stringValue
        )
    }
    
}
