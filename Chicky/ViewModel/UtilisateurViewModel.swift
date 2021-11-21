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
    
    func recupererUtilisateurParID(id: Int?) -> Utilisateur {
        var data: Utilisateur?
        
        AF.request(Constantes.host + "/utilisateur&id=" + String(id!)).responseJSON(completionHandler: { jsonResponse in
            let response = JSON(jsonResponse)[0]
            
            data = Utilisateur(
                nom: response["nom"].stringValue,
                prenom: response["prenom"].stringValue,
                dateNaissance: Date(),
                sexe: Sexe.masculin
            )
        })
        
        return data!
    }
    
    func recupererToutUtilisateur() -> [Utilisateur] {
        var data: [Utilisateur]?
        
        AF.request(Constantes.host + "/utilisateur").responseJSON(completionHandler: { jsonResponse in
            let response = JSON(jsonResponse)
            
            for (_,subJson):(String, JSON) in response {
                data!.append(
                    Utilisateur(
                        nom: subJson["nom"].stringValue,
                        prenom: subJson["prenom"].stringValue,
                        dateNaissance: Date(),
                        sexe: Sexe.masculin
                    )
                )
            }
        })
        
        return data!
    }
    
}
