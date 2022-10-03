//
//  AppData.swift
//  PayWingsOAuthSDK-TestApp
//
//  Created by Tjasa Jan on 02/10/2022.
//

import Foundation


class AppData {
    
    private static var privateShared : AppData?
    
    final class func shared() -> AppData
    {
        guard let iShared = privateShared else {
            privateShared = AppData()
            return privateShared!
        }
        return iShared
    }
    
    private init() {}
    deinit {}
    
    class func destroy() {
        privateShared = nil
    }
    
    
    var accessToken: String?
    var refreshToken: String?
}
