//
//  SelectedLocationView.swift
//  Chicky
//
//  Created by Apple Mac on 2/1/2022.
//

import Foundation
import UIKit

class SelectedLocationView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // VARS
    private var enregistrements : [Enregistrement] = []
    var chosenLocationName: String?
    
    // WIDGETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enregistrements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let contentView = cell?.contentView

        let imageProfile = contentView?.viewWithTag(1) as! UIImageView
        let labelName = contentView?.viewWithTag(2) as! UILabel
        let labelDate = contentView?.viewWithTag(3) as! UILabel
        let profileButton = contentView?.viewWithTag(4) as! UIButton
        
        let enregistrement = enregistrements[indexPath.row]
        
        profileButton.addAction(UIAction(handler: { UIAction in
            let viewController: ProfilView = self.storyboard!.instantiateViewController(withIdentifier: "profile") as! ProfilView
            viewController.profileOfSomeoneElse = enregistrement.utilisateur
            self.present(viewController, animated: true)
        }), for: .touchUpInside)
        
        let compareDateInSeconds = enregistrement.date!.timeIntervalSince(Date())
        print(Date())
        print(enregistrement.date)
        print(compareDateInSeconds)
        let timeSince = DateUtils().secondsToHoursMinutesSeconds(Int(abs(compareDateInSeconds)))
        
        
              print(timeSince.0)
              print(timeSince.1)
              print(timeSince.2)
        
        if (enregistrement.utilisateur?._id == UserDefaults.standard.string(forKey: "idUtilisateur")!){
            
            labelName.text = (enregistrement.utilisateur?.prenom)! + " " + (enregistrement.utilisateur?.nom)! + " (You)"
            
            if timeSince.0 > 0 {
                labelDate.text = "Were here " + String(timeSince.0) + " Hours ago"
            } else if timeSince.1 > 0 {
                labelDate.text = "Were here " + String(timeSince.1) + " Minutes ago"
            } else if timeSince.2 > 0 {
                labelDate.text = "You are here now"
            } else {
                labelDate.text = "You were here a long ago"
            }
            
        } else {
            
            labelName.text = (enregistrement.utilisateur?.prenom)! + " " + (enregistrement.utilisateur?.nom)!
      
            
            if timeSince.0 > 0 {
                labelDate.text = "Was here " + String(timeSince.0) + " Hours ago"
            } else if timeSince.1 > 0 {
                labelDate.text = "Was here " + String(timeSince.1) + " Minutes ago"
            } else if timeSince.2 > 0 {
                labelDate.text = "Is here now"
            } else {
                labelDate.text = "Was here a long ago"
            }
        }
        
        
        
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.clipsToBounds = true
        imageProfile.layer.borderColor = UIColor.white.cgColor
        imageProfile.layer.borderWidth = 5.0
        
        ImageLoader.shared.loadImage(
            identifier: (enregistrement.utilisateur?.idPhoto)!,
            url: IMAGE_URL + (enregistrement.utilisateur?.idPhoto)!,
            completion: { [] image in
                imageProfile.image = image
            })
        
        return cell!
    }
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = chosenLocationName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
        
    }
    
    // METHODS
    func initialize() {
        EnregistrementViewModel.sharedInstance.recupererParLieu(lieu: chosenLocationName!) { success, enregistrementsfromRep in
            if success {
                self.enregistrements = enregistrementsfromRep!
                self.tableView.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load enregistrements "),animated: true)

            }
        }
    }
}
