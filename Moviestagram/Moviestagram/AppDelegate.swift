//
//  AppDelegate.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import UIKit

let appColor = #colorLiteral(red: 0.8431372549, green: 0.1058823529, blue: 0.2666666667, alpha: 1) // UIColor(red: 215, green: 27, blue: 68, alpha: 1)
let appEnvironment = AppEnvironment()

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
