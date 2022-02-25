//
//  ViewController.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 08/11/2021.
//

import UIKit

class MessagerieView: UIViewController, UITableViewDataSource, UITableViewDelegate, ModalTransitionListener {
    
    // VARS
    private var conversations : [Conversation] = []
    private var selectedConversation: Conversation?
    
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
        let blockButton = contentView?.viewWithTag(4) as! UIButton
        
        let conversation = conversations[indexPath.row]
        let recepteur = conversation.recepteur
        
        blockButton.addAction(UIAction(handler: { act in
            let reinitAct = UIAlertAction(title: "Ok", style: .default) {  [self] UIAlertAction in
                initialize()
            }
            
            let alert = UIAlertController(title: "Block user", message: "You can block user, they won't apear in your list and won't be able to contact you", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Block", style: .destructive) { [self] UIAlertAction in
                let recepteurInner = conversations[indexPath.row].recepteur
                print("blocking ----")
                print(recepteurInner)
                print("-------------")
                UtilisateurViewModel.sharedInstance.blockUser(userToBlock: recepteur._id!) { success in
                    if success {
                        self.present(Alert.makeSingleActionAlert(titre: "Success", message: "User has been blocked", action: reinitAct),animated: true)
                        
                        var oldBlockedUsers = UserDefaults.standard.array(forKey: "blockedUsers")
                        oldBlockedUsers?.append(recepteurInner._id!)
                        UserDefaults.standard.set(oldBlockedUsers, forKey: "blockedUsers")
                    } else {
                        self.present(Alert.makeServerErrorAlert(), animated: true)
                    }
                }
            }
            let action2 = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in
                
            }
            alert.addAction(action2)
            alert.addAction(action1)
            self.present(alert,animated: true)
            
        }), for: .touchUpInside)
        
        imageProfile.roundedGrayPhoto()
        
        if (recepteur.idPhoto! != ""){
            ImageLoader.shared.loadImage(
                identifier: recepteur.idPhoto!,
                url: IMAGE_URL + recepteur.idPhoto!,
                completion: { [] image in
                    imageProfile.image = image
                })
        }
        
        
        labelUsername.text = recepteur.prenom! + " " + recepteur.nom!
        labellastMessage.text = conversation.dernierMessage
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedConversation = conversations[indexPath.row]
        self.performSegue(withIdentifier: "conversationSegue", sender: selectedConversation)
    }
    
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conversationSegue" {
            let destination = segue.destination as! ChatView
            destination.currentConversation = selectedConversation
            destination.title = (selectedConversation?.recepteur.prenom)! + " " + (selectedConversation?.recepteur.nom)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModalTransitionMediator.instance.setListener(listener: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
    }
    
    // METHODS
    func popoverDismissed() {
        initialize()
    }
    
    func initialize() {
        self.conversations = []
        self.tableView.reloadData()
        MessagerieViewModel.sharedInstance.recupererMesConversations { [self] success, conversationsfromRep in
            if success {
                self.conversations = []
                
                let blockedUsers = UserDefaults.standard.array(forKey: "blockedUsers") as! [String]
                
                print("blocked Users :")
                print(blockedUsers)
                
                for conversation in conversationsfromRep! {
                    if !blockedUsers.contains((conversation.recepteur._id)!) {
                        conversations.append(conversation)
                    }
                }
                
                self.tableView.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load conversations "),animated: true)
            }
        }
    }
}
