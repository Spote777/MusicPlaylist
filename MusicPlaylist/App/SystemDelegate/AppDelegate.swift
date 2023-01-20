//
//  AppDelegate.swift
//  MusicPlaylist
//
//  Created by Павел Заруцков on 18.01.2023.
//

import UIKit
import Kingfisher
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let cache = ImageCache.default
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        cache.clearCache()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {  }
    
}
