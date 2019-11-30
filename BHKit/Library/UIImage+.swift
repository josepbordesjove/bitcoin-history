//
//  UIImage+.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit

public extension UIImage {
  func tint(with color: UIColor) -> UIImage {
    var image = withRenderingMode(.alwaysTemplate)
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    color.set()
    
    image.draw(in: CGRect(origin: .zero, size: size))
    image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }
}
