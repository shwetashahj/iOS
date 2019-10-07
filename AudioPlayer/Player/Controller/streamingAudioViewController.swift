//
//  streamingAudioViewController.swift
//  Player
//
//  Created by Shweta Shah on 25/09/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class streamingAudioViewController: UIViewController {
    
    @IBOutlet weak var progressingTime: UILabel!
    @IBOutlet weak var audioName: UILabel!
    @IBOutlet weak var totalDuration: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var shuffleBtn: UIButton!
    @IBOutlet weak var musicTrackSlider: UISlider!
    @IBOutlet weak var audioImage: UIImageView!
    @IBOutlet weak var repeatBtbn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingIndicatorContainer: UIView!
    @IBOutlet weak var audioProgressBar: UIProgressView!
    @IBOutlet weak var advertiseProgressBar: UIProgressView!
    
    
   // var audioPlayer : AVPlayer?
    
    var isShuffleOn : Bool = false
    var isRepeatOn : Bool = false
    var audioDuration : Double = 0.0
    var isPlaying : Bool = true
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.loadingIndicator.startAnimating()
       self.loadingIndicatorContainer.isHidden = false
         Global.audioPlayerModel.delegate = self
        let url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
        setUpPlayer(url: url)
       
    }
    
    
    func setUpPlayer(url: String){
        
        if((Global.audioPlayerModel.currentAudioPlayer) != nil){
           
             setUI()
        }else{
             setdefaultUI()
            Global.audioPlayerModel.setplayer(urlString: url) {
                   Global.audioPlayerModel.isplaying = true
                   Global.audioPlayerModel.play()
                 playBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
                
            }
        }
        
        
    }
    
 
    
    func setUI(){
       
        if (Global.audioPlayerModel.isplaying){
             playBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
        }else{
             playBtn.setImage(UIImage(named: "Play.png"), for: .normal)
        }
    }
    
    func setdefaultUI(){
         self.audioProgressBar.progress = 0.0
        self.advertiseProgressBar.progress = 0.0
         
     }
     

/*To Set the music play on lock screen and notification screen**/
    func setUpNotification(){
        
         let commandCenter = MPRemoteCommandCenter.shared()
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: "Song NAme",
            MPMediaItemPropertyArtist: "Song NAme",
            MPMediaItemPropertyArtwork:  MPMediaItemArtwork(image: UIImage(named: "2564114063")!),
            MPMediaItemPropertyPlaybackDuration: audioDuration
        ]

        UIApplication.shared.beginReceivingRemoteControlEvents()
        becomeFirstResponder()
        
        
    }
    
    
}

/*IB Actions*/
extension streamingAudioViewController{
    
      @IBAction func shuffleBtnIsPressed(_ sender: Any) {
          
          if (isShuffleOn == false){
              shuffleBtn.setImage(UIImage(named: "SelectedShuffle.png"), for: .normal)
              isShuffleOn = true
            showToast(message: "Shuffle On", font: UIFont(name: "HelveticaNeue-UltraLight",
                                                          size: 20.0)!)
          }else{
               shuffleBtn.setImage(UIImage(named: "Shuffle.png"), for: .normal)
               isShuffleOn = false
             showToast(message: "Shuffle Off", font: UIFont(name: "HelveticaNeue-UltraLight",
                                                                     size: 20.0)!)
          }
          
      }
      
      @IBAction func previousBtnIsPressed(_ sender: Any) {
          
      }
      
      @IBAction func playBtnIsPressed(_ sender: Any) {
        
        if(Global.audioPlayerModel.isAdvPlaying == true){
            
        }
          
          
          if(Global.audioPlayerModel.isplaying == true){
               playBtn.setImage(UIImage(named: "Play.png"), for: .normal)
              Global.audioPlayerModel.isplaying = false
             // audioPlayer?.pause()
              Global.audioPlayerModel.pause()
             
          }else{
               playBtn.setImage(UIImage(named: "Pause.png"), for: .normal)
              Global.audioPlayerModel.isplaying = true
              //audioPlayer?.play()
              Global.audioPlayerModel.play()
          }
      
      }
      
      @IBAction func nextBtnIsPressed(_ sender: Any) {
          
      }
      
      @IBAction func repeatBtnIsPressed(_ sender: Any) {
          
          if (isRepeatOn == false){
              
              repeatBtbn.setImage(UIImage(named: "SelectedRepeat.png"), for: .normal)
              isRepeatOn = true
            
            showToast(message: "Repeat On", font: UIFont(name: "HelveticaNeue-UltraLight",
                                                                     size: 20.0)!)
          }else{
              repeatBtbn.setImage(UIImage(named: "Repeat.png"), for: .normal)
              isRepeatOn = false
            
            showToast(message: "Repeat Off", font: UIFont(name: "HelveticaNeue-UltraLight",
                                                                     size: 20.0)!)
          }
          
      }
      
      @IBAction func changeAudio(_ sender: Any) {
     
          if let duration = Global.audioPlayerModel.currentAudioPlayer?.currentItem?.duration {
              let totalSeconds = CMTimeGetSeconds(duration)
              
              let value = Float64(musicTrackSlider.value) * totalSeconds
              
              let seekTime = CMTime(value: Int64(value), timescale: 1)
              
              Global.audioPlayerModel.currentAudioPlayer?.seek(to: seekTime, completionHandler: { (completedSeek) in
                  //perhaps do something later here
              })
          }

      }
      
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    
}
extension streamingAudioViewController : audioPlayerDelegate{
    func setAdvertiseProgressBar(currentValue: Float) {
     self.advertiseProgressBar.setProgress(currentValue, animated: true)
    }
    
   
    
    func removeAdvertiseProgressBar() {
        self.advertiseProgressBar.isHidden = true
        self.audioProgressBar.isHidden = false
        self.musicTrackSlider.isHidden = false
         Global.audioPlayerModel.play()
    }
    
  
    
    func showAdvertiseProgressBar() {
        self.advertiseProgressBar.isHidden = false
        self.audioProgressBar.isHidden = true
        self.musicTrackSlider.isHidden = true
        Global.audioPlayerModel.setAdvertiseProgress(urlString: "https://www.android-examples.com/wp-content/uploads/2016/04/Thunder-rumble.mp3")
    }
    

    func stopLoadingIndicator(){
        
        self.loadingIndicator.stopAnimating()
        self.loadingIndicatorContainer.isHidden = true
        
    }
    
    func setTotalDurationLbl(value: String){
        
        self.totalDuration.text = value
        
    }
    
    func setProgressbar(currentValue: Float){
        
        self.audioProgressBar.setProgress(currentValue, animated: true)
        
    }
    
    func setSeekTrack(currentTrackValue: Float){
        
        self.musicTrackSlider.value = currentTrackValue
        
    }
    
    func setCurrentTime(currentTime: String){
        
        self.progressingTime.text = currentTime
        
    }
    
 
  
    
}
