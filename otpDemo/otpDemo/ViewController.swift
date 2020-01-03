//
//  ViewController.swift
//  otpDemo
//
//  Created by Shweta Shah on 18/11/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import  Foundation

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var imh: UIImageView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var OTPTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var urlString = "https://storage.googleapis.com/aawaz-stateless/2019/04/d7530b14-aawaz-category-img-comady-150x150.jpg"

        let url = URL(string:urlString)!
        let data = try? Data(contentsOf: url)

        if let imageData = data {
            let image1 = UIImage(data: imageData)
             self.imh.image = image1
        }
        
        
        if let audioUrl = URL(string: "https://storage.googleapis.com/aawaz-stateless/2019/11/aawaz-bala-movie-review.mp3") {

            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print(destinationUrl)

            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")

                // if the file doesn't exist
            } else {

                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl) { location, response, error in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                    } catch {
                        print(error)
                    }
                }.resume()
            }
        }
       
    
    }
    
    
    
    @IBAction func sendOTPBtnIsPressed(_ sender: Any) {
  PhoneAuthProvider.provider().verifyPhoneNumber("+919022898874", uiDelegate: nil) { (verificationID, error) in
  if let error = error {
   print(error.localizedDescription)
    return
  }
  // Sign in using the verificationID and the code sent to the user
  // ...
}
}
}















//
//    /*
//     * This function is called when user click on send OTP button
//     */
//    @IBAction func sendOTPBtnIsClicked(_ sender: Any) {
//
////
////        //Writing this code here for development purpose
////        var actionItemsVC = HomeViewController()
////        let navigationViewController = UINavigationController(rootViewController: actionItemsVC)
////
////
////        let slideMenuController = SlideMenuController (mainViewController: HomeViewController(), leftMenuViewController: SliderMenuViewController())
////        slideMenuController.changeLeftViewWidth(UIScreen.main.bounds.width - (UIScreen.main.bounds.width/4))
////        self.presentDetail(slideMenuController)
////        return
//
//
//        let numberWithCountryCode: String?
//
////        //Checking the phone is entered or not
////        guard let phoneNumberTextField = "9022898874" else{
////            return
////        }
//
////        //Checking the countryCode is entered or not
////        if let countryCode = self.countryCodeTextField.text{
////           numberWithCountryCode = "\(countryCode)\(phoneNumberTextField)"
////        }else{
////            return
////        }
//
////        //After Merging the phone number and Country checking whether the number is valid
////        guard let phoneNumber =  numberWithCountryCode else{
////            return
////        }
//
//        //OTP generation call.
//        PhoneAuthProvider.provider().verifyPhoneNumber("9022898874", uiDelegate: nil) { (verificationId, error) in
//
//            if error == nil{
//                guard let verifyId = verificationId else{
//                    return
//                }
//
//                //Storing the verification ID in user default So If user goes out of the app.
//                //Application do not miss the verification ID
//                Constants.userDefault.set(verifyId, forKey: "VerificationId")
//                Constants.userDefault.synchronize()
//
//
//               // self.verifyOTPView.isHidden = false
//                //self.requestOTPView.isHidden = true
//
////                if(self.phoneNumberTextField.text != nil){
// //                  self.phoneNumberWithCountryCode.text =
//  //                      "\(self.countryCodeTextField.text!) \(self.phoneNumberTextField.text!)"
////                }
////
//               // self.animateTheRequestLoginView()
//
//            }else{
//                print("unable to get secret verification code from firebase", error?.localizedDescription)
//            }
//        }
//    }
//
//    /*
//     * This function is called when user click on sign in button
//     */
//    @IBAction func signInBtnIsClicked(_ sender: Any) {
//
//        guard let otpCode = self.OTPTextField.text else{
//            return
//        }
//
//        guard let verificationId = Constants.userDefault.string(forKey: "VerificationId") else{
//            return
//        }
//
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpCode)
//
//          Auth.auth().signInAndRetrieveData(with: credential) { (success, error) in
//
//            if(error == nil){
//                print("Successfully Signed In")
//
//            }else{
//               //handle failure
//            }
//        }
//    }
//}
//
struct Constants {

    //To store the value
    static let userDefault = UserDefaults.standard

    static var appDelegate : AppDelegate {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate
    }
}
