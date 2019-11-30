//
//  Color.swift
//  BHUIKit
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit

public struct Color {
  public static var brand: UIColor = .systemBlue
  
  public static var background: UIColor {
    if #available(iOS 13.0, *) {
      return .systemBackground
    } else {
      return .white
    }
  }
  
  public static var secondary: UIColor {
    if #available(iOS 13.0, *) {
      return UIColor.systemGray2
    } else {
      return UIColor.gray
    }
  }

  public static var extraInfoText: UIColor {
    if #available(iOS 13.0, *) {
      return UIColor.systemGray2
    } else {
      return UIColor.gray
    }
  }
  
  public static var infoText: UIColor {
    if #available(iOS 13.0, *) {
      return UIColor.label
    } else {
      return UIColor.black
    }
  }

  public static let tagText = UIColor.white
}
