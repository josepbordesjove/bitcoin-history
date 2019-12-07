//
//  Router.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 07/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHUIKit
import BHKit

class Router: NSObject {
  
  var window: UIWindow?
  let windowScene: UIWindowScene
  
  #if targetEnvironment(macCatalyst)
  let refreshItemIdentifier = NSToolbarItem.Identifier("refreshIdentifier")
  let infoItemIdentifier = NSToolbarItem.Identifier("infoIdentifier")
  #endif
  
  // Create the master view controller
  fileprivate let bitcoinHistoryListViewController = BitcoinHistoryListViewController(store: Store())
  
  init(window: UIWindow?, windowScene: UIWindowScene) {
    self.window = window
    self.windowScene = windowScene
    self.window = UIWindow(windowScene: windowScene)
    super.init()

    configureRootViewController()
  }
  
  private func configureRootViewController() {
    defer {
      window?.makeKeyAndVisible()
    }

    guard NSClassFromString("XCTest") == nil else {
      self.window?.rootViewController = UISplitViewController()
      return
    }
    
    // Configure the split view controller
    #if targetEnvironment(macCatalyst)
    windowScene.sizeRestrictions?.minimumSize = CGSize(width: 0, height: 0)
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
}

// MARK: UISplitViewControllerDelegate

extension Router: UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return true
  }
}

// MARK: NSToolbarDelegate

#if targetEnvironment(macCatalyst)
extension Router: NSToolbarDelegate {
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
