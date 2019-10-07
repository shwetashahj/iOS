//
//  ViewController.swift
//  speechRecognitionDemo
//
//  Created by Shweta Shah on 07/10/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    
    @IBOutlet weak var speechTextView: UITextView!
    @IBOutlet weak var stopRecordingBtn: UIButton!
    @IBOutlet weak var startRecordingBtn: UIButton!
    
    //This is process the audio stream and give update when mic is recieving the audio.
    let audioEngine = AVAudioEngine()
    
    /* Actual speech recognisation is done here. It should be optional because it can fail and return nil.
    You can also set the language here by passing parameter SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    */
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    
    //This allocates the speech as the  user speaks in real time and control buffering
    let request = SFSpeechAudioBufferRecognitionRequest()
    
    //This will be used to manage, cancel, or stop the current recognition task.
    var recognitionTask: SFSpeechRecognitionTask?
    
    //To check the recording state to update buttons state.
    var isRecording : Bool = false
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    
    @IBAction func StartSpeaking(_ sender: Any) {
       
        if isRecording{
            return
        }
        isRecording = true
        self.stopRecordingBtn.isHidden = false
        self.recordAndRecognizeSpeech()
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        
        isRecording = false
        self.stopRecordingBtn.isHidden = true
        recognitionTask?.finish()
        let inputNode = audioEngine.inputNode
        inputNode.removeTap(onBus: 0)
    }
    
    
    //Start the recording
    func recordAndRecognizeSpeech(){
    
        //Audio engine uses what are called nodes to process bits of audio. Here .inputNode creates a singleton for the incoming audio
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        //InstallTap configures the node and sets up the request instance with the proper buffer on the proper bus.
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){buffer ,_ in
            self.request.append(buffer)
            
        }
        
        //prepare the audioEngine for recording
        audioEngine.prepare()
        
        do {
            //start the audioEngine for recording
            try audioEngine.start()
        }
        catch{
            
            return print(error)
        }
        
        //checks to make sure the recognizer is available for the device and for the locale
        guard let myRecognizer = SFSpeechRecognizer() else{
            // this recogniser is not supported for current locale
            return
        }
        
        if !myRecognizer.isAvailable{
            //No recogniser available
            return
        }
        
        //This is where the recognition happens. As I mentioned before, the audio is being sent to an Apple server then comes back as a result object with attributes. 
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: {
            result, error in
            
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                self.speechTextView.text = bestString
                
            } else if let error = error{
                print(error)
            }
        })
        
    }
}

