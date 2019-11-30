//
//  Icon.swift
//  BHUIKit
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit

public struct Icon {
  public static var info: UIImage? {
    if #available(iOS 13.0, *) {
      return UIImage(systemName: "info.circle")
    } else {
      // TODO: Return a fallback image for previous 13 OS
      return nil
    }
  }
  
  public static var star: UIImage? {
    if #available(iOS 13.0, *) {
      return UIImage(systemName: "star.fill")
    } else {
      // TODO: Return a fallback image for previous 13 OS
      return nil
    }
  }
  
  public static var bitcoin: UIImage? {
    if #available(iOS 13.0, *) {
      return UIImage(systemName: "bitcoinsign.circle")
    } else {
      // TODO: Return a fallback image for previous 13 OS
      return nil
    }
  }
}
