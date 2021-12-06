//
//  Accueil.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit

class AccueilView: UIViewController  {
    
    // VAR
    var liked = false
    var publications : [Publication] = []
    var currentPublication : Publication?
    var publicationCounter = 0
    var oldUiView : UIView?
    var newUiView : UIView?
    
    // WIDGET
    @IBOutlet weak var swipeAreaView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var publicationImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    // METHODS
    func setupLayout() {
        PublicationViewModel().getAllPublications { success, results in
            if success {
                self.publications.append(contentsOf: results!)
            } else {
                
            }
        }
    }
    
    @IBAction func topSwipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer ) {
        if gestureRecognizer.state == .ended {
            nextPublication(swipeIsRight: false)
        }
    }
    
    @IBAction func downSwipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer ) {
        if gestureRecognizer.state == .ended {
            nextPublication(swipeIsRight: true)
        }
    }
    
    func nextPublication(swipeIsRight: Bool) {
        print("Switch user")
        if publicationCounter != publications.count {
            currentPublication = publications[publicationCounter]
            
            oldUiView = newUiView
            
            if swipeIsRight {
                UIView.animate(withDuration: 1, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
                    // put here the code you would like to animate
                    self.oldUiView?.frame.origin.x = 1000
                    self.oldUiView?.frame.origin.y = 300
                    self.oldUiView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
                }, completion: {(finished:Bool) in
                    // the code you put here will be compiled once the animation finishes
                    self.oldUiView!.removeFromSuperview()
                })
            } else {
                UIView.animate(withDuration: 1, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
                    // put here the code you would like to animate
                    self.oldUiView?.frame.origin.x = -1000
                    self.oldUiView?.frame.origin.y = 300
                    self.oldUiView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
                }, completion: {(finished:Bool) in
                    // the code you put here will be compiled once the animation finishes
                    self.oldUiView!.removeFromSuperview()
                })
            }
            
            
            newUiView = makePublication(description: publications[publicationCounter].description!, idPhoto: "example-1")
            swipeAreaView.addSubview(newUiView!)
            swipeAreaView.sendSubviewToBack(newUiView!)
            
            publicationCounter += 1
            
        } else {
            self.present(Alert.makeAlert(titre: "Notice", message: "Out of users !"),animated: true)
        }
    }
    
    func makePublication(description: String , idPhoto: String) -> UIView {
        let card = UIView()
        card.frame = CGRect(x: 0, y: 0, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
        card.backgroundColor = UIColor(white: 0.9, alpha: 1)
        card.layer.cornerRadius = 20
        
        let image = UIImageView(image: UIImage(named: idPhoto))
        image.frame = CGRect(x: 20, y: 20, width: card.frame.width - 40, height: card.frame.height - 150)
        image.contentMode = .scaleAspectFit
        image.tag = 1
        image.layer.cornerRadius = 20
        
        let descriptionLabel = UILabel()
        descriptionLabel.tag = 2
        descriptionLabel.text = description
        descriptionLabel.frame = CGRect(x: 0, y: image.frame.height + 50, width: card.frame.width, height: 50)
        descriptionLabel.textAlignment = .center
        
        let likeButton = UIButton()
        likeButton.setTitle("Send a message", for: .normal)
        likeButton.setTitleColor(UIColor.tintColor, for: .normal)
        likeButton.frame = CGRect(x: 30, y: image.frame.height + 100, width: card.frame.width / 2, height: 40)
        likeButton.addTarget(self, action: #selector(AccueilView.likeButtonAction), for: .touchUpInside)
        
        let commentButton = UIButton()
        commentButton.setImage(UIImage(systemName: "heart"), for: .normal)
        commentButton.setTitleColor(UIColor.blue, for: .normal)
        commentButton.frame = CGRect(x: likeButton.frame.width + 50, y: image.frame.height + 100, width: card.frame.width / 3, height: 40)
        commentButton.addTarget(self, action: #selector(AccueilView.showCommentsAction), for: .touchUpInside)
        
        card.addSubview(image)
        card.addSubview(descriptionLabel)
        card.addSubview(likeButton)
        card.addSubview(commentButton)
        
        return card
    }
    
    @objc func likeButtonAction(sender: UIButton) {
        
        LikeViewModel().addLike(like: Like(seen: false, liked: currentPublication )) { success in
            self.currentLikeButton?.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @objc func showCommentsAction(sender: UIButton) {
        let chat = Chat(date: Date(), lastMessage: "This chat hasn't started yet")
        ChatViewModel().addChat(chat: chat, senderId: PublicationDefaults.standard.string(forKey: "publicationId")!, receiverId: (currentPublication?._id)!, completed: { success in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not add chat"),animated: true)
            }
        })
    }
    
    
}
