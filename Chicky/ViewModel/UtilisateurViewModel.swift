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
    
    func inscription(utilisateur: Utilisateur, completed: @escaping (Bool) -> Void) {
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
    
    func connexion(email: String, mdp: String, completed: @escaping (Bool, Any?) -> Void) {
        AF.request(Constantes.host + "/utilisateur/connexion",
                   method: .post,
                   parameters: ["email": email, "mdp": mdp])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let utilisateur = self.makeItem(jsonItem: jsonData["utilisateur"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "utilisateurToken")
                    print(utilisateur)
                    
                    completed(true, utilisateur)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func reEnvoyerConfirmationEmail(email: String, completed: @escaping (Bool) -> Void) {
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
    
    func motDePasseOublie(email: String, codeDeReinit: String, completed: @escaping (Bool) -> Void) {
        AF.request(Constantes.host + "/utilisateur/motDePasseOublie",
                   method: .post,
                   parameters: ["email": email, "codeDeReinit": codeDeReinit])
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
    
    func changerMotDePasse(email: String, nouveauMotDePasse: String, completed: @escaping (Bool) -> Void) {
        AF.request(Constantes.host + "/utilisateur/changerMotDePasse",
                   method: .put,
                   parameters: ["email": email,"nouveauMotDePasse": nouveauMotDePasse])
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
    
    func manipulerUtilisateur(utilisateur: Utilisateur, methode: HTTPMethod, completed: @escaping (Bool) -> Void) {
        
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
        //let isoDate = jsonItem["dateNaissance"]
        let isoDate = "2016-04-14T10:44:00+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        
        return Utilisateur(
            _id: jsonItem["_id"].stringValue,
            pseudo: jsonItem["pseudo"].stringValue,
            email: jsonItem["email"].stringValue,
            mdp: jsonItem["mdp"].stringValue,
            nom: jsonItem["nom"].stringValue,
            prenom: jsonItem["prenom"].stringValue,
            dateNaissance: date,
            idPhoto: jsonItem["idPhoto"].stringValue,
            sexe: jsonItem["sexe"].boolValue,
            score: jsonItem["score"].intValue,
            bio: jsonItem["bio"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue
        )
    }
    
}
