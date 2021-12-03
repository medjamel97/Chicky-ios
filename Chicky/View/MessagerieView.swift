//
//  ViewController.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 08/11/2021.
//

import UIKit

class MessagerieView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // VARS
    private var models = [Conversation]()
    
    // WIDGETS
    @IBOutlet weak var messagesTableView: UITableView!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        //let viewModel = MessageViewModel;
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contentView = cell.contentView
        
        let imageProfile = contentView.viewWithTag(1) as! UIImageView
        let labelUsername = contentView.viewWithTag(2) as! UILabel
        let labelMessage = contentView.viewWithTag(3) as! UILabel
        //let buttonSupprimer = contentView.viewWithTag(4) as! UIButton
        
        imageProfile.image = UIImage(named: "image-person")
        labelUsername.text = "username"
        //labelMessage.text = model.dernierMessage
        
        return cell
    }
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
    }
    
    // METHODS
    private func configureModels() {
        let examples = [
            "Jamel", "Maher", "Anis", "Akram"
        ]
        
        for example in examples{
         //   models.append(Conversation(dernierMessage: example))
        }
    }
    
    // ACTIONS
    
}

