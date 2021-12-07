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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLayout()
    }
    
    // METHODS
    func setupLayout() {
        publicationCounter = 0
        currentPublication = nil
        
        PublicationViewModel().getAllPublications { [self] success, results in
            if success {
                self.publications.append(contentsOf: results!)

                if results!.count > 0 {
                    if results![publicationCounter].idPhoto != nil {
                        
                        currentPublication = results![publicationCounter]
                        
                        let url = "http://localhost:3000/img/"+(currentPublication?.idPhoto)!
                        print(url)
                        ImageLoader.shared.loadImage(identifier:(currentPublication?.idPhoto)!, url: url, completion: { [self]image in

                            
                            newUiView = makePublicationCard(description: publications[publicationCounter].description!, uiImage: image!)
                            
                            swipeAreaView.addSubview(newUiView!)
                            
                            publicationCounter += 1
                        })
                    }
                }
                
            }
        }
    }
    
    @IBAction func topSwipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer ) {
        if gestureRecognizer.state == .ended {
            nextPublication(swipeIsTop: true)
        }
    }
    
    @IBAction func downSwipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer ) {
        if gestureRecognizer.state == .ended {
            nextPublication(swipeIsTop: false)
        }
    }
    
    func nextPublication(swipeIsTop: Bool) {
        print("Switch user")
        if publicationCounter < publications.count {
            currentPublication = publications[publicationCounter]
            
            oldUiView = newUiView
            
            if swipeIsTop {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
                    // put here the code you would like to animate
                    self.oldUiView?.frame.origin.y = -1000
                }, completion: {(finished:Bool) in
                    // the code you put here will be compiled once the animation finishes
                    self.oldUiView!.removeFromSuperview()
                })
            } else {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
                    // put here the code you would like to animate
                    self.oldUiView?.frame.origin.x = 1000
                }, completion: {(finished:Bool) in
                    // the code you put here will be compiled once the animation finishes
                    self.oldUiView!.removeFromSuperview()
                })
            }
            
            let url = "http://localhost:3000/img/"+(publications[publicationCounter].idPhoto)!
            print(url)
            if publications[publicationCounter].idPhoto != nil {
                ImageLoader.shared.loadImage(identifier:(publications[publicationCounter].idPhoto)!, url: url, completion: { [self]image in
                    
                    newUiView = makePublicationCard(description: publications[publicationCounter].description!, uiImage: image!)
                    swipeAreaView.addSubview(newUiView!)
                    swipeAreaView.sendSubviewToBack(newUiView!)
                    
                    publicationCounter += 1
                })
            }
            
            
            
        } else {
            self.present(Alert.makeAlert(titre: "Notice", message: "Fin de publications !"),animated: true)
        }
    }
    
    func makePublicationCard(description: String , uiImage: UIImage) -> UIView {
        print("creating pub")
        
        let card = UIView()
        card.frame = CGRect(x: 0, y: 0, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
        card.backgroundColor = UIColor(white: 0.9, alpha: 1)
        card.layer.cornerRadius = 20
        
        let image = UIImageView(image: uiImage)
        image.frame = CGRect(x: 0, y: 0, width: card.frame.width, height: card.frame.height)
        image.contentMode = .scaleToFill
        image.tag = 1
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        
        let descriptionLabel = UILabel()
        descriptionLabel.tag = 2
        descriptionLabel.text = description
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.frame = CGRect(x: 30, y: image.frame.height - 100, width: image.frame.width, height: 50)
        
        /*let likeButton = UIButton()
        likeButton.setTitle("Send a message", for: .normal)
        likeButton.setTitleColor(UIColor.tintColor, for: .normal)
        likeButton.frame = CGRect(x: 30, y: image.frame.height + 100, width: card.frame.width / 2, height: 40)
        likeButton.addTarget(self, action: #selector(AccueilView.likeButtonAction), for: .touchUpInside)
        
        let commentButton = UIButton()
        commentButton.setImage(UIImage(systemName: "heart"), for: .normal)
        commentButton.setTitleColor(UIColor.blue, for: .normal)
        commentButton.frame = CGRect(x: likeButton.frame.width + 50, y: image.frame.height + 100, width: card.frame.width / 3, height: 40)
        commentButton.addTarget(self, action: #selector(AccueilView.showCommentsAction), for: .touchUpInside)*/
        
        card.addSubview(image)
        card.addSubview(descriptionLabel)
        //card.addSubview(likeButton)
        //card.addSubview(commentButton)
        
        return card
    }
    
    @objc func likeButtonAction(sender: UIButton) {
        /*
        LikeViewModel().addLike(like: Like(seen: false, liked: currentPublication )) { success in
            self.currentLikeButton?.setTitleColor(UIColor.red, for: .normal)
        }
        */
    }
    
    @objc func showCommentsAction(sender: UIButton) {
        /*
        let chat = Chat(date: Date(), lastMessage: "This chat hasn't started yet")
        ChatViewModel().addChat(chat: chat, senderId: PublicationDefaults.standard.string(forKey: "publicationId")!, receiverId: (currentPublication?._id)!, completed: { success in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not add chat"),animated: true)
            }
        })*/
    }
    
    
}
