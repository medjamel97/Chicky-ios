//
//  EnregistrementViewModel.swift
//  Geochat
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

class EnregistrementViewModel {
    
    static let sharedInstance = EnregistrementViewModel()
    
    func recupererParLieu(lieu: String, completed: @escaping (Bool, [Enregistrement]?) -> Void ) {
        AF.request(HOST_URL + "enregistrement/par-lieu",
                   method: .post,
                   parameters: [
                    "lieu": lieu
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var enregistrements : [Enregistrement]? = []
                    for singleJsonItem in JSON(response.data!)["enregistrements"] {
                        enregistrements!.append(self.makeEnregistrement(jsonItem: singleJsonItem.1))
                    }
                    completed(true, enregistrements)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func ajouter(enregistrement: Enregistrement, completed: @escaping (Bool) -> Void ) {
        AF.request(HOST_URL + "enregistrement/ajouter",
                   method: .post,
                   parameters: [
                    "idUtilisateur": UserDefaults.standard.string(forKey: "idUtilisateur")!,
                    "lieu": enregistrement.lieu
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func makeEnregistrement(jsonItem: JSON) -> Enregistrement {
        Enregistrement(
            _id: jsonItem["_id"].stringValue,
            lieu: jsonItem["lieu"].stringValue,
            date: DateUtils.formatFromString(string: jsonItem["date"].stringValue),
            utilisateur: UtilisateurViewModel.sharedInstance.makeItem(jsonItem: jsonItem["utilisateur"])
        )
    }
}
