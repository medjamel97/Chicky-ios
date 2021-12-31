//
//  ChatView.swift
//  Chicky
//
//  Created by Apple Mac on 14/12/2021.
//
import UIKit
import MessageKit

class ChatView: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    // VARS
    var currentConversation: Conversation?
    var messages = [MessageType]()
    var timer: Timer?
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadMessages()
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    override func viewDidLayoutSubviews() {
        messageInputBar.sendButton.addAction(UIAction(handler: { [self] UIAction in
            let messageDescription = messageInputBar.inputTextView.text!
            messageInputBar.inputTextView.text = ""
            
            MessagerieViewModel.sharedInstance.envoyerMessage(recepteur: (currentConversation?.recepteur._id)!, description: messageDescription) { success, messageFromRep in
                if success {
                    let currentUser = (currentConversation?.envoyeur)!
                    var message = messageFromRep!
                    
                    message.sender = Sender(senderId: currentUser._id!, displayName: currentUser.prenom! + " " + currentUser.nom!)
                    messages.append(message)
                    messagesCollectionView.reloadData()
                } else {
                    self.present(Alert.makeServerErrorAlert(),animated: true)
                }
            }
        }), for: .touchUpInside)
    }
    
    // PROTOCOLS
    func currentSender() -> SenderType {
        let currentUser = (currentConversation?.envoyeur)!
        return Sender(senderId: currentUser._id!, displayName: currentUser.prenom! + " " + currentUser.nom!)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    // FUNCTIONS
    @objc func reloadMessages() {
        MessagerieViewModel.sharedInstance.recupererMesMessages(idConversation: (currentConversation?._id)!) { [self] success, messagesFromRep in
            if success {
                messages = messagesFromRep!
                messagesCollectionView.reloadData()
            } else {
                self.present(Alert.makeServerErrorAlert(),animated: true)
            }
        }
    }
    
    func startTimer () {
        guard timer == nil else { return }
        
        timer =  Timer.scheduledTimer(
            timeInterval: 5,
            target      : self,
            selector    : #selector(reloadMessages),
            userInfo    : nil,
            repeats     : true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
