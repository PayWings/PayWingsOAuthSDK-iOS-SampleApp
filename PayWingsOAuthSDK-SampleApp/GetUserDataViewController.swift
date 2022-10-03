//
//  GetUserDataViewController.swift
//  PayWingsOAuthSDK-TestApp
//
//  Created by Tjasa Jan on 03/10/2022.
//

import UIKit
import PayWingsOAuthSDK


class GetUserDataViewController : UIViewController, GetUserDataCallbackDelegate {
    
    
    @IBOutlet weak var ErrorMessage: UILabel!
    @IBOutlet weak var UserID: UILabel!
    @IBOutlet weak var FirstName: UILabel!
    @IBOutlet weak var LastName: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var EmailConfirmed: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    
    
    var callback = GetUserDataCallback()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ErrorMessage.isHidden = true
        
        callback.delegate = self
    }
    
    
    @IBAction func onGetData(_ sender: Any) {
        showLoading()
        ErrorMessage.isHidden = true
        
        PayWingsOAuthClient.instance()?.getUserData(accessToken: AppData.shared().accessToken ?? "", callback: callback)
    }
    
    
    
    func onUserData(userId: String, firstName: String?, lastName: String?, email: String?, emailConfirmed: Bool, phoneNumber: String?) {
        UserID.text = "UserID: " + userId
        FirstName.text = "FirstName: " + (firstName ?? "")
        LastName.text = "LastName: " + (lastName ?? "")
        Email.text = "Email: " + (email ?? "")
        EmailConfirmed.text = "EmailConfirmed: " + emailConfirmed.description
        PhoneNumber.text = "PhoneNumber: " + (phoneNumber ?? "")
        hideLoading()
     }
    
    func onError(error: PayWingsOAuthSDK.OAuthErrorCode, errorMessage: String?) {
        ErrorMessage.text = errorMessage ?? error.description
        ErrorMessage.isHidden = false
        hideLoading()
    }
    
}
