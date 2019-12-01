//
//  Icon.swift
//  BHUIKit
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit

public struct Icon {
  private static let bundle = Bundle(for: TagView.self)
  
  public static var info: UIImage? {
    if #available(iOS 13.0, *) {
      return UIImage(systemName: "info.circle")
    } else {
      return UIImage(named: "info", in: Icon.bundle, compatibleWith: nil)
    }
  }
  
  public static var star: UIImage? {
    if #available(iOS 13.0, *) {
      return UIImage(systemName: "star.fill")
    } else {
      return UIImage(named: "star", in: Icon.bundle, compatibleWith: nil)
    }
  }
}
