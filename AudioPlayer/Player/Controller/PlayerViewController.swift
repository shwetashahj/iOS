//
//  PlayerViewController.swift
//  MediaPlayer
//
//  Created by Shweta Shah on 23/09/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import AVFoundation

class PlayerViewController: UIViewController, AVAudioPlayerDelegate{

    
     var audioPlayer : AVAudioPlayer = AVAudioPlayer()
    
    var audioSession = AVAudioSession.sharedInstance()
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var musicTrackSlider: UISlider!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var repeatBtn: UIButton!
    @IBOutlet weak var shuffleBtn: UIButton!
     var nowplaying = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            let audioPath = Bundle.main.path(forResource: "Happy", ofType: "mp3")
            //check the audio path
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
        }catch{
            //ERROR
        }

        musicTrackSlider.maximumValue = Float(audioPlayer.duration)
        
        var timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: Selector(("updateAudioSlider")) , userInfo: nil, repeats: true)
        
        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//              try?AVAudioSession.sharedInstance().setActive(true)
//        }catch{
//
//        }
    }
    

    @IBAction func shuffleBtnIsPressed(_ sender: Any) {
        
    }
    
    @IBAction func previousBtnIsPressed(_ sender: Any) {
        
    }
    
    @IBAction func playBtnIsPressed(_ sender: Any) {
        
        if(audioPlayer.isPlaying){
             audioPlayer.stop()
            
        }else{
             audioPlayer.play()
        }
        
         setUpNotification()
        
       
    }
    
    @IBAction func nextBtnIsPressed(_ sender: Any) {
        
    }
    
    @IBAction func repeatBtnIsPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func changeAudio(_ sender: Any) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(musicTrackSlider.value)
        audioPlayer.prepareToPlay()
        
          audioPlayer.play()
        
        
        
    }
    
    @objc
    func updateAudioSlider(){
        
        musicTrackSlider.value = Float(audioPlayer.currentTime)
        
        
    }
    
    
    func setUpNotification(){
        
         let commandCenter = MPRemoteCommandCenter.shared()
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: "Song NAme",
            MPMediaItemPropertyArtist: "Song NAme",
            MPMediaItemPropertyArtwork:  MPMediaItemArtwork(image: UIImage(named: "2564114063")!),
            MPMediaItemPropertyPlaybackDuration: audioPlayer.duration
        ]
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        becomeFirstResponder()
        
        
    }
    
    
   
    override func remoteControlReceived(with event: UIEvent?) {
        if let receivedEvent = event {
            if (receivedEvent.type == .remoteControl) {
                switch receivedEvent.subtype {
                case .remoteControlTogglePlayPause:
                    print("play ")
                case .remoteControlPlay:
                    print("play")
                case .remoteControlPause:
                    print("pause")
                case .remoteControlNextTrack:
                    print("next")
                case .remoteControlPreviousTrack:
                    print("previoous")
                default:
                    print("received sub type \(receivedEvent.subtype) Ignoring")
                }
            }
        }
    }
    
}
