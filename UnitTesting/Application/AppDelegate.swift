//
//  AppDelegate.swift
//  UnitTesting


import UIKit
import Scyther

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        AppRouter.shared.start()

        Scyther.instance.start()
        return true
    }
}

