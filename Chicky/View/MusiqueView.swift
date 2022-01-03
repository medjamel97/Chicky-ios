//
//  Musique.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import AVFAudio

class MusiqueView: UIViewController, AVAudioPlayerDelegate {
    
    // VAR
    var currentMusic: Musique?
    var audioPlayer: AVAudioPlayer!
    var canPlay = false
    var updater : CADisplayLink! = nil
    
    // WIDGET
    @IBOutlet weak var titreMusiqueLabel: UILabel!
    @IBOutlet weak var artisteMusiqueLabel: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var progressBar: UISlider!
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePlayer()
        initializeView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    // METHODS
    func initializePlayer() {
        playImage.tintColor = UIColor.black
        
        AudioLoader.sharedInstance.loadMusic(url: MUSIQUE_URL + currentMusic!.emplacementFichier) { [self] url in
            if url != nil {
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: url!)
                    audioPlayer.prepareToPlay()
                    audioPlayer.volume = 1.0
                    audioPlayer.play()
                    
                    playImage.tintColor = UIColor.tintColor
                    canPlay = true
                } catch let error as NSError {
                    //self.player = nil
                    print(error.localizedDescription)
                } catch {
                    print("AVAudioPlayer init failed")
                }
            } else {
                print("URL ERROR")
                print(MUSIQUE_URL + currentMusic!.emplacementFichier)
            }
        }
    }
    
    func initializeView() {
        titreMusiqueLabel.text = currentMusic?.titre
        artisteMusiqueLabel.text = currentMusic?.artiste
        
        ImageLoader.shared.loadImage(
            identifier: currentMusic!.emplacementImageAlbum,
            url: IMAGE_URL + currentMusic!.emplacementImageAlbum,
            completion: { [] image in
                self.musicImage.image = image
            })
        
    }
    
    @objc func trackAudio() {
        progressBar.value = Float(audioPlayer.currentTime * 100.0 / audioPlayer.duration)
    }
    
    // ACTIONS
    @IBAction func playAction(_ sender: Any) {
        if canPlay {
            playImage.image = UIImage(systemName: "pause.circle.fill")
            
            updater = CADisplayLink(target: self, selector: #selector(self.trackAudio))
            updater.frameInterval = 1
            updater.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
            
            //startTime.text = "\(player.currentTime)"
            progressBar.minimumValue = 0
            progressBar.maximumValue = 100 // Percentage
      
            audioPlayer.play()
        } else {
            self.audioPlayer.stop()
            playImage.image = UIImage(systemName: "play.circle.fill")
        }
        canPlay = !canPlay
    }
}
