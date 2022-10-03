//
//  PhoneNumberViewController.swift
//  PayWingsOAuthSDK-TestApp
//
//  Created by Tjasa Jan on 01/10/2022.
//

import UIKit
import PayWingsOAuthSDK



class PhoneNumberViewController : UIViewController, SignInWithPhoneNumberRequestOtpCallbackDelegate {
    
    
    @IBOutlet weak var MobileNumber: UITextField!
    @IBOutlet weak var ErrorMessage: UILabel!
    
    var callback = SignInWithPhoneNumberRequestOtpCallback()
    
    var otpL: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        callback.delegate = self
        
        ErrorMessage.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MobileNumber.becomeFirstResponder()
    }
    

    @IBAction func onSubmitPhoneNumebr(_ sender: Any) {
        showLoading()
        ErrorMessage.isHidden = true
        let phoneNUmber = MobileNumber.text ?? ""
        MobileNumber.resignFirstResponder()
        
        PayWingsOAuthClient.instance()?.signInWithPhoneNumberRequestOtp(phoneNumber: phoneNUmber, smsContentTemplate: nil, callback: callback)
    }
    
    
    // SignInWithPhoneNumberRequestOtpCallbackDelegate
    func onShowOtpInputScreen(otpLength: Int) {
        debugPrint("otpLength: " + otpLength.description)
        otpL = otpLength
        hideLoading()
        performSegue(withIdentifier: "confirmMobileNumber", sender: nil)
    }
    
    func onError(error: PayWingsOAuthSDK.OAuthErrorCode, errorMessage: String?) {
        
        ErrorMessage.text = errorMessage ?? error.description
        ErrorMessage.isHidden = false
        hideLoading()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmMobileNumber" {
            guard let vc = segue.destination as? ConfirmPhoneNumberViewController else { return }
            vc.mobileNumber = MobileNumber.text
            vc.otpLength = otpL
        }
    }
    
}
