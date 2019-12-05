//
//  AppDelegate.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHUIKit
import BHKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
 
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    guard NSClassFromString("XCTest") == nil else {
        self.window?.rootViewController = UISplitViewController()
        return true
    }
    
    // Configure the split view controller
    let bitcoinHistoryListViewController = BitcoinHistoryListViewController(store: Store())
    let masterViewController = UINavigationController(rootViewController: bitcoinHistoryListViewController)
    masterViewController.navigationBar.tintColor = Color.brand

    let rootViewController = UISplitViewController()
    rootViewController.view.backgroundColor = Color.background
    rootViewController.preferredDisplayMode = .allVisible
    rootViewController.delegate = self
    rootViewController.viewControllers = [masterViewController]
    
    window = UIWindow()
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()

    return true
  }
}

// MARK: UISplitViewControllerDelegate

extension AppDelegate: UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return true
  }
}
