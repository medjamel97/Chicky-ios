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
    
    func connexion(email: String, mdp: String, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/utilisateur/connexion",
                   method: .post,
                   parameters: ["email": email, "mdp": mdp])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func verifierConfirmationEmail(email: String, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/utilisateur/verifierConfirmationEmail",
                   method: .post,
                   parameters: ["email": email])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print(JSON(response)["message"])
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func reEnvoyerConfirmationEmail(email: String, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/utilisateur/reEnvoyerConfirmationEmail",
                   method: .post,
                   parameters: ["email": email])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func inscription(utilisateur: Utilisateur, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/utilisateur/inscription",
                   method: .post,
                   parameters: [
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
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func recupererUtilisateurParID(_id: Int?) -> Utilisateur {
        var data: Utilisateur?
        
        AF.request(Constantes.host + "/utilisateur",
                   method: .get,
                   parameters: ["_id": String(_id!)])
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
    
    func manipulerUtilisateur(utilisateur: Utilisateur, methode: HTTPMethod, completed: @escaping DownloadComplete) {
        
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
                   ])
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
