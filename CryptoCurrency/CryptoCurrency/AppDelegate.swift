//
//  AppDelegate.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 11/9/2023.
//

import UIKit
import CoreData

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let hasInternet = InternetManager.shared.isInternetAvailable()
        window?.rootViewController = hasInternet ? TabBarController.instantiateFromNib() : InternetViewController()
        window?.makeKeyAndVisible()
        return true
    }

    func restartApp() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController.instantiateFromNib()
        window?.makeKeyAndVisible()
    }
}
