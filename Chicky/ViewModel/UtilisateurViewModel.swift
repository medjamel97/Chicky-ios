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
    
    func uploadImage(imgData: Data, params: [String: Any]) {
     /*   let image = UIImage.init(named: "myImage")
        let imgData = image!.pngData()
        
        let parameters = ["name": rname] //Optional for extra parameter
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: "fileset",fileName: "file.png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },
                  to:"mysite/upload.php")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }*/
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
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    print(utilisateur)
                    
                    completed(true, utilisateur)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func loginWithSocialApp(email: String, nom: String, completed: @escaping (Bool, Utilisateur?) -> Void ) {
        AF.request(Constantes.host + "/utilisateur/connexionAvecReseauSocial",
                   method: .post,
                   parameters: ["email": email, "nom": nom],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData["utilisateur"])
                    
                    print("this is the new token value : " + jsonData["token"].stringValue)
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func recupererUtilisateurParToken(userToken: String, completed: @escaping (Bool, Utilisateur?) -> Void ) {
        print("Looking for user --------------------")
        AF.request(Constantes.host + "/utilisateur/recupererUtilisateurParToken",
                   method: .post,
                   parameters: ["token": userToken],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let utilisateur = self.makeItem(jsonItem: jsonData["utilisateur"])
                    print("Found utilisateur --------------------")
                    print(utilisateur)
                    print("-------------------------------")
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
                    //"_id" : utilisateur._id!,
                    //"pseudo": utilisateur.pseudo!,
                    "email": utilisateur.email!,
                    //"mdp": utilisateur.mdp!,
                    "nom": utilisateur.nom!,
                    "prenom": utilisateur.prenom!,
                    //"dateNaissance": utilisateur.dateNaissance!,
                    //"idPhoto": utilisateur.idPhoto!,
                    "sexe": utilisateur.sexe!,
                    //"score": utilisateur.score!,
                    //"bio": utilisateur.bio!
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
