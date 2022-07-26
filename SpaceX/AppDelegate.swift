//
//  AppDelegate.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 11.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let navigationViewController = UINavigationController(rootViewController: RocketPageViewController())
        navigationViewController.navigationBar.isHidden = true
        navigationViewController.navigationBar.tintColor = .white
        
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        return true
    }
}

