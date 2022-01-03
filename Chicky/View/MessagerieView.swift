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
        let buttonDel = contentView?.viewWithTag(4) as! UIButton
         
        
        buttonDel.addAction(UIAction(handler: { act in
            MessagerieViewModel.sharedInstance.supprimerConversation (_id: self.conversations[indexPath.row]._id!) { success in
                if success {
                    self.initialize()
                } else {
                    print("error while deleting chat")
                }
            }
        }), for: .touchUpInside)
        
        imageProfile.roundedGrayPhoto()
        
        let conversation = conversations[indexPath.row]
        let recepteur = conversation.recepteur
        
        ImageLoader.shared.loadImage(
            identifier: recepteur.idPhoto!,
            url: IMAGE_URL + recepteur.idPhoto!,
            completion: { [] image in
                imageProfile.image = image
            })
        
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
        MessagerieViewModel.sharedInstance.recupererMesConversations { success, conversationsfromRep in
            if success {
                self.conversations = conversationsfromRep!
                self.tableView.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load conversations "),animated: true)

            }
        }
    }
}

