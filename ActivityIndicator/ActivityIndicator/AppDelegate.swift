//
//  AppDelegate.swift
//  ActivityIndicator
//
//  Created by Arken Sarsenov on 01.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        //window?.rootViewController = ExampleVC()
        window?.rootViewController = ViewController()
        
        return true
    }
}
