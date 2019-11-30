//
//  BitconHistorySection.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation
import BHKit

enum BitconHistorySection: Equatable {
  case today(detail: PriceDetail)
  case historic(list: HistoricalList)
  
  var position: Int {
    switch self {
    case .today:
      return 0
    case .historic:
      return 1
    }
  }
  
  static func == (lhs: BitconHistorySection, rhs: BitconHistorySection) -> Bool {
    switch lhs {
    case .today:
      switch rhs {
      case .today:
        return true
      default:
        return false
      }
    case .historic:
      switch rhs {
      case .historic:
        return true
      default:
        return false
      }
    }
  }
}

extension Array where Iterator.Element == BitconHistorySection {
  var containsTodaySection: Bool {
    var containsTodaySection = false

    self.forEach { (section) in
      switch section {
      case .today:
        containsTodaySection = true
      case .historic:
        if !containsTodaySection {
          containsTodaySection = false
        }
      }
    }
    
    return containsTodaySection
  }
  
  var containsHistoricList: Bool {
    var containsHistoricList = false

    self.forEach { (section) in
      switch section {
      case .today:
        if !containsHistoricList {
          containsHistoricList = false
        }
      case .historic:
        containsHistoricList = true
      }
    }
    
    return containsHistoricList
  }
  
  var containsPlaceholders: Bool {
    return false
  }
}

