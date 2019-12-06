//
//  SceneDelegate.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 06/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHUIKit
import BHKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  let refreshItemIdentifier = NSToolbarItem.Identifier("refreshIdentifier")
  let infoItemIdentifier = NSToolbarItem.Identifier("infoIdentifier")
  
  fileprivate let bitcoinHistoryListViewController = BitcoinHistoryListViewController(store: Store())
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let windowScene = (scene as? UIWindowScene) else { return }
    windowScene.sizeRestrictions?.minimumSize = CGSize(width: 0, height: 0)
    
    self.window = UIWindow(windowScene: windowScene)
    
    defer {
      window?.makeKeyAndVisible()
    }
    
    guard NSClassFromString("XCTest") == nil else {
      self.window?.rootViewController = UISplitViewController()
      return
    }
    
    // Configure the split view controller
    #if targetEnvironment(macCatalyst)
    let masterViewController = bitcoinHistoryListViewController
    
    if let titlebar = windowScene.titlebar {
      let toolbar = NSToolbar(identifier: "bitcoinHistoryToolbar")
      toolbar.allowsUserCustomization = false
      toolbar.delegate = self
      titlebar.titleVisibility = .hidden
      titlebar.toolbar = toolbar
    }
    #else
    let masterViewController = UINavigationController(rootViewController: bitcoinHistoryListViewController)
    masterViewController.navigationBar.tintColor = Color.brand
    #endif
    
    let rootViewController = UISplitViewController()
    rootViewController.view.backgroundColor = Color.background
    rootViewController.preferredDisplayMode = .allVisible
    rootViewController.delegate = self
    rootViewController.viewControllers = [masterViewController]
    
    window?.rootViewController = rootViewController
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }
}

// MARK: UISplitViewControllerDelegate

extension SceneDelegate: UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return true
  }
}

// MARK: NSToolbarDelegate

#if targetEnvironment(macCatalyst)
extension SceneDelegate: NSToolbarDelegate {
  func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
    if itemIdentifier == refreshItemIdentifier {
      let barButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "arrow.clockwise"),
        style: .done,
        target: bitcoinHistoryListViewController,
        action: #selector(bitcoinHistoryListViewController.forceUpdateTodaysRate)
      )
      return NSToolbarItem(itemIdentifier: refreshItemIdentifier, barButtonItem: barButtonItem)
    } else if itemIdentifier == infoItemIdentifier {
      let barButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "info.circle"),
        style: .done,
        target: bitcoinHistoryListViewController.router,
        action: #selector(bitcoinHistoryListViewController.router?.routeToInfoDisclaimer)
      )
      return NSToolbarItem(itemIdentifier: refreshItemIdentifier, barButtonItem: barButtonItem)
    }
    
    return nil
  }
  
  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
      return [NSToolbarItem.Identifier.flexibleSpace, refreshItemIdentifier, infoItemIdentifier]
  }

  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
      return toolbarDefaultItemIdentifiers(toolbar)
  }
}
#endif
