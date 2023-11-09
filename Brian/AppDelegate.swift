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
    
        if #available(iOS 13.0, *) {
            UIApplication.shared.inputView?.overrideUserInterfaceStyle = .light
        }
        
        //MARK: - Delete exisiting realm database
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

        
         //MARK: - Realm database location URL
//        let realmURL = Realm.Configuration.defaultConfiguration.fileURL
//        print("Realm Database File URL: \(realmURL)")
        
        //MARK: - Realm migration block for version updates
        
        let config = Realm.Configuration(
                    schemaVersion: 1,
                    migrationBlock: { migration, oldSchemaVersion in
                        if oldSchemaVersion < 1 {
                            // Perform migration tasks here
                            
                            migration.enumerateObjects(ofType: Needs.className()) { oldObject, newObject in
                                newObject?["id"] = UUID().uuidString
                            }
                        }
                    }
                )
                Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

