//
//  AppDelegate.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
 
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    guard NSClassFromString("XCTest") == nil else {
        self.window?.rootViewController = UIViewController()
        return true
    }
    
    // Configure the split view controller
    let bitcoinHistoryListViewController = BitcoinHistoryListViewController(nibName: nil, bundle: nil)
    let masterViewController = UINavigationController(rootViewController: bitcoinHistoryListViewController)
    let bitcoinPriceDetailViewController = BitcoinPriceDetailViewController(nibName: nil, bundle: nil)
    let detailViewController = UINavigationController(rootViewController: bitcoinPriceDetailViewController)

    let rootViewController = UISplitViewController()
    rootViewController.delegate = self
    rootViewController.viewControllers = [masterViewController, detailViewController]
    
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
