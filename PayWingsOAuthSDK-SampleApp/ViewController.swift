//
//  ViewController.swift
//  PayWingsOAuthSDK-TestApp
//
//  Created by Tjasa Jan on 01/10/2022.
//

import UIKit
import PayWingsOAuthSDK
import InAppSettingsKit


class ViewController: UIViewController, IASKSettingsDelegate {

    @IBOutlet weak var SdkVersion: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let version = Bundle(for: PayWingsOAuthClient.self).object(forInfoDictionaryKey:"CFBundleShortVersionString") as? String {
            SdkVersion.text = "v" + version
        }
    }
    
    

    @IBAction func onStartAuth(_ sender: Any) {
        
        let domain = UserDefaults.standard.string(forKey: "domain") ?? ""
        let apiKey = UserDefaults.standard.string(forKey: "api_key") ?? ""
        
        PayWingsOAuthClient.initialize(environmentType: .TEST, apiKey: apiKey, domain: domain)
        
        performSegue(withIdentifier: "enterMobileNumber", sender: nil)
    }
    
    
    
    @IBAction func onOpenSettings(_ sender: Any) {
        
        let appSettingsViewController = IASKAppSettingsViewController()
        appSettingsViewController.neverShowPrivacySettings = true
        appSettingsViewController.showCreditsFooter = false
        appSettingsViewController.delegate = self
        
        let navController = UINavigationController(rootViewController: appSettingsViewController)
        navController.modalPresentationStyle = .fullScreen
        self.show(navController, sender: self)
    }
    
    func settingsViewControllerDidEnd(_ settingsViewController: IASKAppSettingsViewController) {
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}





extension UIViewController {
    
    func showLoading() {
        guard self.view.viewWithTag(0123) == nil else { return }
        
        let activityView = UIActivityIndicatorView(frame: .zero)
        activityView.style = .medium
        activityView.color = .black
        activityView.startAnimating()
        
        activityView.center = self.view.center
        activityView.tag = 0123
        self.view.addSubview(activityView)
        
        self.view.isUserInteractionEnabled = false
    }
    func hideLoading() {
        if let activityView = self.view.viewWithTag(0123) {
            activityView.removeFromSuperview()
        }
        self.view.isUserInteractionEnabled = true
    }
}
