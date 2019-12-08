//
//  BitconHistorySection.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import Foundation
import BHKit

enum BitconHistorySection: Equatable, Hashable {
  case today(detail: RateList)
  case historic(list: RateList)
  case placeholder(amount: Int)
  
  var position: Int {
    switch self {
    case .today:
      return 0
    case .placeholder:
      return 1
    case .historic:
      return 2
    }
  }
  
  static func == (lhs: BitconHistorySection, rhs: BitconHistorySection) -> Bool {
    switch lhs {
    case .placeholder:
      switch rhs {
      case .placeholder:
        return true
      default:
        return false
      }
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
      case .historic, .placeholder:
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
      case .today, .placeholder:
        if !containsHistoricList {
          containsHistoricList = false
        }
      case .historic:
        containsHistoricList = true
      }
    }
    
    return containsHistoricList
  }
  
  var containsPlaceholder: Bool {
    var containsPlaceholder = false
    
    self.forEach { (section) in
      switch section {
      case .placeholder:
        if !containsPlaceholder {
          containsPlaceholder = true
        }
      case .historic, .today:
        containsPlaceholder = false
      }
    }
    
    return containsPlaceholder
  }
  
  var indexOfPlaceholder: Int? {
    var placeholderIndex: Int?
    
    for index in 0...(self.count-1) {
      switch self[index] {
      case .placeholder:
        placeholderIndex = index
      default:
        break
      }
    }
    
    return placeholderIndex
  }
}

