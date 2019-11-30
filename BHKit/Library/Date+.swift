//
//  Date+.swift
//  BHKit
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation

public extension Date {
  enum DateFormat {
    case short
    case long
    case dateHour
    
    var stringFormat: String {
      switch self {
      case .short:
        return "yyyy-MM-dd"
      case .long:
        return "MMM d, yyyy HH:mm:ss Z"
      case .dateHour:
        return "MMM d, yyyy HH:mm"
      }
    }
  }
  
  // TODO: Explain why this has been created as static
  private static let currentCalendar = Calendar.current
  private static let dateFormatter = DateFormatter()
  
  func toFormattedString(format: DateFormat = DateFormat.short) -> String {
    guard let currentTimeZoneAbbreviation = TimeZone.current.abbreviation() else {
      assert(false, "The abbreviation should not be nil")
      return ""
    }

    Date.dateFormatter.dateFormat = format.stringFormat
    Date.dateFormatter.timeZone = TimeZone(abbreviation: currentTimeZoneAbbreviation)
    
    return Date.dateFormatter.string(from: self)
  }
  
  static func from(date: String, format: DateFormat) -> Date? {
    Date.dateFormatter.dateFormat = format.stringFormat
    
    guard let newDate = Date.dateFormatter.date(from: date) else {
      return nil
    }
    
    return newDate
  }
}
