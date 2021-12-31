//
//  EvaluationViewModel.swift
//  Carypark
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

class EvaluationViewModel {
    
    static let sharedInstance = EvaluationViewModel()
    
    func recupererEvaluationParPublication(idPublication: String?, completed: @escaping (Bool, [Evaluation]?) -> Void ) {
        AF.request(Constantes.host + "evaluation/par-publication",
                   method: .post,
                   parameters: [
                    "publication": idPublication!
                   ], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var evaluations : [Evaluation]? = []
                    for singleJsonItem in jsonData["evaluations"] {
                        evaluations!.append(self.makeEvaluation(jsonItem: singleJsonItem.1))
                    }
                    completed(true, evaluations)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func recupererEvaluationParUtilisateur(idPublication: String?, completed: @escaping (Bool, Evaluation?) -> Void ) {
        AF.request(Constantes.host + "evaluation/par-utilisateur-publication",
                   method: .post,
                   parameters: [
                    "publication": idPublication!,
                    "utilisateur": UserDefaults.standard.string(forKey: "idUtilisateur")!
                   ], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true, self.makeEvaluation(jsonItem: JSON(response.data!)["evaluation"]))
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func ajouterEvaluation(idPublication: String, note: Int, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "evaluation",
                   method: .post,
                   parameters: [
                    "note": String(note),
                    "publication": idPublication,
                    "utilisateur": UserDefaults.standard.string(forKey: "idUtilisateur")!
                   ], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func modifierEvaluation(id: String, note: Int, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "evaluation",
                   method: .put,
                   parameters: [
                    "_id": id,
                    "note": String(note)
                   ], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func supprimerEvaluation(_id: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "evaluation",
                   method: .delete,
                   parameters: [
                    "_id": _id!
                   ], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func makeEvaluation(jsonItem: JSON) -> Evaluation {
        Evaluation(
            _id: jsonItem["_id"].stringValue,
            note: jsonItem["note"].intValue
        )
    }
}
