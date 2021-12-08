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
    var publicationCounter = 0
    var isInitialized = false
    
    var previousPublication : Publication?
    var currentPublication : Publication?
    var nextPublication : Publication?
    
    var previousPublicationView = UIView()
    var currentPublicationView = UIView()
    var nextPublicationView = UIView()
    
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
        publicationCounter = 0
        currentPublication = nil
        
        previousPublicationView.backgroundColor = UIColor.red
        previousPublicationView.frame = CGRect(x: 0, y: -1000, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
    
        currentPublicationView.backgroundColor = UIColor.green
        currentPublicationView.frame = CGRect(x: 0, y: 0, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
         
        nextPublicationView.backgroundColor = UIColor.blue
        nextPublicationView.frame = CGRect(x: 0, y: 1000, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
     
        swipeAreaView.addSubview(previousPublicationView)
        swipeAreaView.addSubview(currentPublicationView)
        swipeAreaView.addSubview(nextPublicationView)
        
        PublicationViewModel().getAllPublications { [self] success, results in
            if success {
                self.publications.append(contentsOf: results!)
                
                if publications.count > 0 {
                    setupPublications()
                    isInitialized = true
                }
            }
        }
    }
    
    // METHODS
    func setupPublications(){
        
        print("Counter is :" + String(publicationCounter))
        print("-----------")
        if publicationCounter > 0  {
            print("making previousPub")
            previousPublication = publications[publicationCounter - 1]
            waitForImage(element: previousPublicationView, elementIndex: -1, publication: previousPublication!)
        } else {
            previousPublication = nil
        }
        
        if publications.count >= publicationCounter {
            print("making currentPub")
            currentPublication = publications[publicationCounter]
            waitForImage(element: currentPublicationView, elementIndex: 0, publication: currentPublication!)
        }
        
        if publications.count > publicationCounter + 1  {
            print("making nextPub")
            nextPublication = publications[publicationCounter + 1]
            waitForImage(element: nextPublicationView, elementIndex: 1, publication: nextPublication!)
        } else {
            nextPublication = nil
        }
        print("-----------")
    }
    
    func waitForImage(element: UIView, elementIndex: Int, publication : Publication) {
        ImageLoader.shared.loadImage(
            identifier: publication.idPhoto!,
            url: Constantes.images + publication.idPhoto!,
            completion: { [self]image in
                makePublicationCard(element: element, elementIndex: elementIndex, description: publication.description!, uiImage: image!)
            })
    }
    
    func makePublicationCard(element: UIView, elementIndex: Int, description: String , uiImage: UIImage) {
        
        //element.backgroundColor = UIColor(white: 0.9, alpha: 1)
        element.layer.cornerRadius = 20
        
        let image = UIImageView(image: uiImage)
        image.frame = CGRect(x: 0, y: 0, width: element.frame.width, height: element.frame.height)
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
        
        //element.addSubview(image)
        //element.addSubview(descriptionLabel)
        //element.addSubview(likeButton)
        //element.addSubview(commentButton)
    }
    
    func navigateToNextPublication() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
            // put here the code you would like to animate
            self.previousPublicationView.frame.origin.y -= 1000
            self.currentPublicationView.frame.origin.y -= 1000
            self.nextPublicationView.frame.origin.y -= 1000
        }, completion: { [self](finished:Bool) in
            /*let aux = currentPublication
            currentPublication = nextPublication
            nextPublication = aux*/
            previousPublicationView.backgroundColor = UIColor.red
            previousPublicationView.frame = CGRect(x: 0, y: -1000, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
        
            currentPublicationView.backgroundColor = UIColor.green
            currentPublicationView.frame = CGRect(x: 0, y: 0, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
             
            nextPublicationView.backgroundColor = UIColor.blue
            nextPublicationView.frame = CGRect(x: 0, y: 1000, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
        })
    }
    
    func navigateToPreviousPublication() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
            // put here the code you would like to animate
            self.previousPublicationView.frame.origin.y += 1000
            self.currentPublicationView.frame.origin.y += 1000
            self.nextPublicationView.frame.origin.y += 1000
        }, completion: { [self](finished:Bool) in
            previousPublicationView.backgroundColor = UIColor.red
            previousPublicationView.frame = CGRect(x: 0, y: -1000, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
        
            currentPublicationView.backgroundColor = UIColor.green
            currentPublicationView.frame = CGRect(x: 0, y: 0, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
             
            nextPublicationView.backgroundColor = UIColor.blue
            nextPublicationView.frame = CGRect(x: 0, y: 1000, width: swipeAreaView.frame.width, height: swipeAreaView.frame.height)
        })
    }
    
    @objc func likeButtonAction(sender: UIButton) {
    }
    
    @objc func showCommentsAction(sender: UIButton) {
    }
    
    @IBAction func topSwipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer ) {
        if gestureRecognizer.state == .ended {
            if ((nextPublication) != nil){
                publicationCounter += 1
                
                navigateToNextPublication()
                setupPublications()
            } else {
                nextPublicationView.removeFromSuperview()
                print("last one")
            }
        }
    }
    
    @IBAction func downSwipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer ) {
        if gestureRecognizer.state == .ended {
            if ((previousPublication) != nil){
                publicationCounter -= 1
                
                navigateToPreviousPublication()
                setupPublications()
            } else {
                previousPublicationView.removeFromSuperview()
                print("first one")
            }
        }
    }
}
