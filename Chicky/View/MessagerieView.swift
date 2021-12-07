//
//  ViewController.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 08/11/2021.
//

import UIKit

class MessagerieView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // VARS
    private var conversations : [Conversation] = []
    
    // WIDGETS
    @IBOutlet weak var tableView: UITableView!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let contentView = cell?.contentView
        
        let imageProfile = contentView?.viewWithTag(1) as! UIImageView
        let labelUsername = contentView?.viewWithTag(2) as! UILabel
        let labellastMessage = contentView?.viewWithTag(3) as! UILabel
      
        labelUsername.text = "recepteur?.nom"
        labellastMessage.text = conversations[indexPath.row].dernierMessage
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            ConversationViewModel().supprimerConversation(_id: conversations[indexPath.row]._id) { success in
                if success {
                    print("deleted chat")
                    self.conversations.remove(at: indexPath.row)
                    tableView.reloadData()
                } else {
                    print("error while deleting chat")
                }
            }
        }
    }
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializeHistory()
    }
    
    // METHODS
    func initializeHistory() {
        
        ConversationViewModel().getAllConversation{success, conversationsfromRep in
            if success {
                self.conversations = conversationsfromRep!
                self.tableView.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load conversations "),animated: true)

            }
        }
    }
    
    // ACTIONS
    
}

