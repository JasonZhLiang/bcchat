//
//  AppDelegate.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-08.
//

import UIKit
import BrainCloud

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var _bc: BrainCloudWrapper = BrainCloudWrapper();
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppDelegate._bc.getBCClient().enableLogging(true)
        AppDelegate._bc.initialize(Bundle.main.infoDictionary?["serverUrl"] as? String,
                                   secretKey: Bundle.main.infoDictionary?["secretKey"] as? String,
                                   appId: Bundle.main.infoDictionary?["appId"] as? String,
                                   appVersion: Bundle.main.infoDictionary?["appVersion"] as? String,
                                   companyName: Bundle.main.infoDictionary?["companyName"] as? String,
                                   appName: Bundle.main.infoDictionary?["appName"] as? String)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

