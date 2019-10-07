//
//  AudioModel.swift
//  Player
//
//  Created by Shweta Shah on 27/09/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation
import MediaPlayer

enum mediaPlayerState{
    case kPlaying
    case kPaused
}


protocol audioPlayerDelegate {
    
    func setCurrentTime(currentTime:String)
    func setSeekTrack(currentTrackValue : Float)
    func setProgressbar(currentValue : Float)
 
    func setTotalDurationLbl(value : String)
    func stopLoadingIndicator()
    func showAdvertiseProgressBar()
    func removeAdvertiseProgressBar()
   func setAdvertiseProgressBar(currentValue : Float)
    
}

class AudioModel : NSObject{
    
    var delegate : audioPlayerDelegate?
    
    var currentAudioPlayer: AVPlayer?
    var advertiseAudioPlayer: AVPlayer?
   // var audioSession = AVAudioSession.sharedInstance()
    
     var isplaying: Bool = false
     var isShuffleOn : Bool = false
     var isRepeatOn : Bool = false
    var audioDuration : Double = 0.0
    var audioProgress : Double = 0.0
    var timer:Timer!
    var isAddPlayed : Bool = false
    var isAdvPlaying : Bool = false
    var playAdvTime : Double = 0.0
    
    
    
    //Playing
    func play(){
        currentAudioPlayer?.play()
    }
    
    //Pause
    func pause(){
        currentAudioPlayer?.pause()
    }
    
    //Stop
    func stop(){
    }
    
    //SetPlayer
     func setplayer(urlString : String, completion: ()->()){
        
        if let url = URL(string: urlString){
            
             let playerItem = AVPlayerItem( url:url as URL)
             currentAudioPlayer = AVPlayer(playerItem:playerItem)
             currentAudioPlayer?.automaticallyWaitsToMinimizeStalling = false
           // timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: "addAdvertise", userInfo: nil, repeats: true)
            //currentAudioPlayer?.perform(Selector(("addAdvertise")), with: nil, afterDelay: 10)
           // currentAudioPlayer?.perform(Selector(("addAdvertise")), with: nil, afterDelay: 10)
            //(Selector("addAdvertise"), with: nil, with: 10)
        currentAudioPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
      
            
             completion()
        }
        
        let interval = CMTime(value: 1, timescale: 2)
        currentAudioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                   
                   let seconds = CMTimeGetSeconds(progressTime)
                   let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                   let minutesString = String(format: "%02d", Int(seconds/60))
                  
                   
                    self.delegate?.setCurrentTime(currentTime: "\(minutesString):\(secondsString)")
                
            self.playAdvTime = (self.audioDuration/2)
            print(self.playAdvTime)
            if(seconds > self.playAdvTime && self.isAddPlayed == false){
                 self.isAdvPlaying = true
                    self.isAddPlayed = true
                               self.addAdvertise()
                    
                   }
            if let duration = self.currentAudioPlayer?.currentItem?.duration {
                       let durationSeconds = CMTimeGetSeconds(duration)
                       self.audioDuration = durationSeconds
                self.audioProgress = seconds / durationSeconds
                self.delegate?.setSeekTrack(currentTrackValue: Float(seconds / durationSeconds))
                       CMTimeShow(self.availableDuration())
                   }
               })
        
    }
func addAdvertise(){
         
         currentAudioPlayer?.pause()
         self.delegate?.showAdvertiseProgressBar()
         
         
     }
    
    func availableDuration() -> CMTime
       {
           
           if let  currentTime = currentAudioPlayer?.currentTime(){
           guard let timeRange = self.currentAudioPlayer?.currentItem?.loadedTimeRanges.map({ $0.timeRangeValue }).first(where: { $0.containsTime(currentTime) }) else {

                   return .zero
           }
         
           let seconds = CMTimeGetSeconds(timeRange.end)
           let valueForProgressiveBar = Float(seconds / self.audioDuration)
         
            
            self.delegate?.setProgressbar(currentValue: valueForProgressiveBar)
        
           }
           return .zero
        
       }
    
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           
        
        
              //this is when the player is ready and rendering frames
                 if keyPath == "currentItem.loadedTimeRanges" {
                          
                  
                    self.delegate?.stopLoadingIndicator()
                     if let duration = currentAudioPlayer?.currentItem?.duration {
                           // To render the total duration label under the seek
                           let seconds = CMTimeGetSeconds(duration)
                      
                            let secondsText = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                            let minutesText = String(format: "%02d", Int(seconds) / 60)
                            self.delegate?.setTotalDurationLbl(value: "\(minutesText):\(secondsText)")
                        
                        
                 }
         
                 /* This is one more way to check whether the audio is ready to play or not*/
                 /*if (audioPlayer.status == .readyToPlay) {
                     //playButton.enabled = YES;
                      print(change)
                                self.loadingIndicator.stopAnimating()
                                self.loadingIndicatorContainer.isHidden = true
                 } else if (audioPlayer.status == .failed) {
                     // something went wrong. player.error should contain some information
                 }*/
         
            
           
     }
    
    
 
    }
}

extension AudioModel{
    
    /*To play advertise*/
    func setAdvertiseProgress(urlString: String){
            
            if let url = URL(string: urlString){
                
                 let playerItem = AVPlayerItem( url:url as URL)
                 advertiseAudioPlayer = AVPlayer(playerItem:playerItem)
                 advertiseAudioPlayer?.automaticallyWaitsToMinimizeStalling = false
                //advertiseAudioPlayer?.perform(#selector(addAdvertise), with: nil, afterDelay: 10)
           // advertiseAudioPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
                NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: advertiseAudioPlayer?.currentItem)
                        
                advertiseAudioPlayer?.play()
                 
            }
            
            let interval = CMTime(value: 1, timescale: 2)
            advertiseAudioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                       let seconds = CMTimeGetSeconds(progressTime)
              
                
//
//                       let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
//                       let minutesString = String(format: "%02d", Int(seconds/60))
//
//
                       // self.delegate?.setCurrentTime(currentTime: "\(minutesString):\(secondsString)")
                      
                       
                if let duration = self.advertiseAudioPlayer?.currentItem?.duration {
                           let durationSeconds = CMTimeGetSeconds(duration)
                           self.audioDuration = durationSeconds
                    self.audioProgress = seconds / durationSeconds
                    self.delegate?.setAdvertiseProgressBar(currentValue: Float(seconds / durationSeconds))
                           CMTimeShow(self.availableDuration())
                       }
                   })
            
        }
    
    
    @objc func playerDidFinishPlaying(note: NSNotification){
            print("Finished Playing")
        
        
        self.delegate?.removeAdvertiseProgressBar()
        self.isAdvPlaying = false
        
        
       
    }
    
     //NotificationCenter.default.removeObserver(self)
}

