//
//  BitcoinHistorySection.swift
//  BitcoinHistoryTests
//
//  Created by Josep Bordes Jové on 30/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

@testable import Bitcoin_History
import XCTest
import BHKit

class BitcoinHistorySectionTests: XCTestCase {
  
  var todaySection: BitconHistorySection!
  var todaySection1: BitconHistorySection!
  
  var historicList: BitconHistorySection!
  var historicList1: BitconHistorySection!
  
  var placeholder: BitconHistorySection!
  var placeholder1: BitconHistorySection!
  
  override func setUp() {
    todaySection = .today(detail: RateList.fake)
    todaySection1 = .today(detail: RateList.fake1)
    
    historicList = .historic(list: RateList.fake)
    historicList1 = .historic(list: RateList.fake1)
    
    placeholder = .placeholder(amount: 1)
    placeholder1 = .placeholder(amount: 15)
  }
  
  override func tearDown() {
  }
  
  func testBitconHistorySectionEquatable() {
    
    XCTAssert(todaySection == todaySection1, "The today's sections must be equal")
    XCTAssert(historicList == historicList1, "The historic's sections must be equal")
    XCTAssert(placeholder == placeholder1, "The placeholders sections must be equal")
    
    XCTAssert(todaySection != historicList, "The today and historic sections must be different")
    XCTAssert(todaySection1 != historicList1, "The today and historic sections must be different")
    XCTAssert(placeholder != todaySection1, "The today and placeholder sections must be different")
    XCTAssert(placeholder1 != historicList, "The historic and placeholder sections must be different")
  }
  
  func testContainsTodaySection() {
    let arrayWithTodaySection: [BitconHistorySection] = [todaySection, historicList]
    let arrayWithoutTodaySection: [BitconHistorySection] = [historicList]
    
    XCTAssert(arrayWithTodaySection.containsTodaySection, "The array should contain the today section")
    XCTAssertFalse(arrayWithoutTodaySection.containsTodaySection, "The array shouldn't contain the today section")
  }
  
  func testContainsHistoricList() {
    let arrayWithHistoricSection: [BitconHistorySection] = [todaySection, historicList]
    let arrayWithoutHistoricSection: [BitconHistorySection] = [todaySection]
    
    XCTAssert(arrayWithHistoricSection.containsHistoricList, "The array should contain the historic section")
    XCTAssertFalse(arrayWithoutHistoricSection.containsHistoricList, "The array shouldn't contain the historic section")
  }
  
  func testContainsPlaceholder() {
    let arrayWithPlaceholderSection: [BitconHistorySection] = [todaySection, historicList, placeholder]
    let arrayWithoutPlaceholderSection: [BitconHistorySection] = [todaySection, historicList]
    
    XCTAssert(arrayWithPlaceholderSection.containsPlaceholder, "The array should contain the placeholder section")
    XCTAssertFalse(arrayWithoutPlaceholderSection.containsPlaceholder, "The array shouldn't contain the placeholder section")
  }
  
  func testContainsIndexOfPlaceholder() {
    let arrayWithPlaceholderSection: [BitconHistorySection] = [todaySection, historicList, placeholder]
    let arrayWithoutPlaceholderSection: [BitconHistorySection] = [todaySection, historicList]
    
    XCTAssertEqual(arrayWithPlaceholderSection.indexOfPlaceholder, 2, "The array should return the index of the placeholder section")
    XCTAssertNil(arrayWithoutPlaceholderSection.indexOfPlaceholder, "The array should return the nil index")
  }
}
