//
//  AppDelegate.swift
//  AvitoTest
//
//  Created by Violence on 06.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let navigationController = UINavigationController()
		let configurator = OptionsConfigurator()
		let view = configurator.makeOptionsModule(with: navigationController)
		navigationController.setViewControllers([view], animated: false)
		navigationController.isNavigationBarHidden = true
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		return true
	}
}

