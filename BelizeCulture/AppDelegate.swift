//
//  AppDelegate.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/7/30.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let mainVC = MainViewController()
        let detailVC = DetailViewController()
        let cardVC = CardViewController()
        let welcomeVC = WelcomeViewController()
        let naviVC = UINavigationController(rootViewController: welcomeVC)
        naviVC.isNavigationBarHidden = true
        let tabBarVC = MainTabBarController()
        let ICDFIntroductionPage = ICDFIntroductionViewController()
        window?.rootViewController = naviVC
//        window?.rootViewController = ICDFIntroductionPage

        Thread.sleep(forTimeInterval: 1.5)

        return true
    }
}


