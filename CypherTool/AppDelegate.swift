//
//  AppDelegate.swift
//  CypherTool
//
//  Created by Piotr Fraccaro on 29/09/2019.
//  Copyright © 2019 Piotr Fraccaro. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let assembler = Assembler([MainViewAssembly()], container: SwinjectStoryboard.defaultContainer)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupLogger()
        print(7.modInv(26))
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

// MARK: - Initialize logger

extension AppDelegate {
    
    func setupLogger() {
        let log = SwiftyBeaver.self
        let file = FileDestination()
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M"
        log.addDestination(file)
        log.addDestination(console)
    }
    
}
