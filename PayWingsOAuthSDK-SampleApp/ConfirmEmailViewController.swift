//
//  ConfirmEmailViewController.swift
//  PayWingsOAuthSDK-TestApp
//
//  Created by Tjasa Jan on 01/10/2022.
//

import UIKit
import PayWingsOAuthSDK


class ConfirmEmailViewController : UIViewController, CheckEmailVerifiedCallbackDelegate {
    
    
    var email: String!
    
    @IBOutlet weak var CheckEmailText: UILabel!
    @IBOutlet weak var ErrorMessage: UILabel!
    
    var callback = CheckEmailVerifiedCallback()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ErrorMessage.isHidden = true
        CheckEmailText.text = "Email verification required: " + email
        
        callback.delegate = self
    }
    
    
    @IBAction func onCheckEmailVerified(_ sender: Any) {
        showLoading()
        ErrorMessage.isHidden = true
        
        PayWingsOAuthClient.instance()?.checkEmailVerified(callback: callback)
    }
    
    
    func onEmailNotVerified() {
        ErrorMessage.text = "Email not verified"
        ErrorMessage.isHidden = false
        hideLoading()
    }
    
    func onSignInSuccessful(refreshToken: String, accessToken: String, accessTokenExpirationTime: Int64) {
        debugPrint("AccessToken: " + accessToken)
        debugPrint("RefreshToken: " + refreshToken)
        debugPrint("ExpirationTime: " + accessTokenExpirationTime.description)
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


