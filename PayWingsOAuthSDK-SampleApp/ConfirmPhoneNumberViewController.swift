//
//  ConfirmPhoneNumberViewController.swift
//  PayWingsOAuthSDK-SampleApp
//
//  Created by Tjasa Jan on 01/10/2022.
//

import UIKit
import PayWingsOAuthSDK


class ConfirmPhoneNumberViewController : UIViewController, SignInWithPhoneNumberVerifyOtpCallbackDelegate {
    
    
    var mobileNumber: String!
    var otpLength: Int!
    
    @IBOutlet weak var VerificationCodeText: UILabel!
    @IBOutlet weak var VerificationCode: UITextField!
    
    @IBOutlet weak var ErrorMessage: UILabel!
    
    var callback = SignInWithPhoneNumberVerifyOtpCallback()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        callback.delegate = self
        
        ErrorMessage.isHidden = true
        VerificationCodeText.text = "Enter " + otpLength.description + "-digit verification code"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        VerificationCode.becomeFirstResponder()
    }
    
    
    @IBAction func onSubmitVerificationCode(_ sender: Any) {
        showLoading()
        ErrorMessage.isHidden = true
        VerificationCode.resignFirstResponder()
        
        PayWingsOAuthClient.instance()?.signInWithPhoneNumberVerifyOtp(otp: VerificationCode.text ?? "", callback: callback)
    }
    
    
    
    // SignInWithPhoneNumberVerifyOtpCallbackDelegate
    func onShowEmailConfirmationScreen(email: String, autoEmailSent: Bool) {
        AppData.shared().userEmail = email
        AppData.shared().emailSent = autoEmailSent
        hideLoading()
        performSegue(withIdentifier: "checkEmailVerified", sender: nil)
    }
    
    func onShowRegistrationScreen() {
        hideLoading()
        performSegue(withIdentifier: "userRegistration", sender: nil)
    }
    
    func onVerificationFailed() {
        ErrorMessage.text = "OTP verification failed"
        ErrorMessage.isHidden = false
        hideLoading()
    }
    
    func onSignInSuccessful(refreshToken: String, accessToken: String, accessTokenExpirationTime: Int64) {
        AppData.shared().accessToken = accessToken
        AppData.shared().refreshToken = refreshToken
        hideLoading()
        performSegue(withIdentifier: "getUserData", sender: nil)
    }
    
    func onUserSignInRequired() {
        ErrorMessage.text = "Sign in is required - please enter your phone number"
        ErrorMessage.isHidden = false
        hideLoading()
    }
    
    func onError(error: PayWingsOAuthSDK.OAuthErrorCode, errorMessage: String?) {
        ErrorMessage.text = errorMessage ?? error.description
        ErrorMessage.isHidden = false
        hideLoading()
    }
    
    
    
}
