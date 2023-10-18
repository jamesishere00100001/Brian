//
//  AppDelegate.swift
//  Brian
//
//  Created by James Attersley on 09/06/2023.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
//        // Delete exisiting realm database
//        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
//
//        do {
//            let fileManager = FileManager.default
//            try fileManager.removeItem(at: realmURL)
//        } catch {
//            print("Error deleting Realm file: \(error)")
//        }
//        
//        Realm.Configuration.defaultConfiguration = Realm.Configuration()

        
//         Realm database location URL
//        let realmURL = Realm.Configuration.defaultConfiguration.fileURL
//        print("Realm Database File URL: \(realmURL)")
        
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

