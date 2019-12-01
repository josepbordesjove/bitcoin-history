//
//  RateListTests.swift
//  BHKitTests
//
//  Created by Josep Bordes Jové on 01/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import XCTest
import BHKit

class RateListTests: XCTestCase {
  
  var rateList: RateList!
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    rateList = nil
  }
  
  func testBasicInit() {
    // Given
    let disclaimer = "Fake disclaimer"
    let updatedDate = Date()
    let currentCurrency = Currency.eur
    let list = [Rate.fake]
    
    // When
    rateList = RateList(disclaimer: disclaimer, updatedDate: updatedDate, currentCurrency: currentCurrency, list: list)
    
    // Then
    XCTAssert(rateList.disclaimer == disclaimer, "The rate list should have disclaimer properly set")
    XCTAssert(rateList.updatedDate == updatedDate, "The rate list should have updatedDate properly set")
    XCTAssert(rateList.currentCurrency == currentCurrency, "The rate list should have currentCurrency properly set")
    XCTAssert(rateList.list.count == list.count, "The rate list should have list properly set")
  }
  
  func testInitFromCurrentPriceResponse() {
    // Given
    let currentPriceResponse = CurrentPriceResponse.fake
    let updatedDate = Date.from(date: currentPriceResponse.time.updated, format: .long)

    // When
    rateList = RateList(response: currentPriceResponse, currentCurrency: .eur)
    
    // Then
    XCTAssert(rateList.disclaimer == currentPriceResponse.disclaimer, "The rate list should have disclaimer properly set")
    XCTAssert(rateList.updatedDate == updatedDate, "The rate list should have updatedDate properly set")
    XCTAssert(rateList.currentCurrency == .eur, "The rate list should have currentCurrency properly set")
    XCTAssert(rateList.list.count == currentPriceResponse.bpi.count, "The rate list should have list properly set")
  }
  
  func testInitHistoricalResponse() {
    // Given
    let historicalResponse = HistoricalResponse.fake
    let updatedDate = Date.from(date: historicalResponse.time.updated, format: .long)
    
    // When
    rateList = RateList(response: historicalResponse, currentCurrency: .eur)
    
    // Then
    XCTAssert(rateList.disclaimer == historicalResponse.disclaimer, "The rate list should have disclaimer properly set")
    XCTAssert(rateList.updatedDate == updatedDate, "The rate list should have updatedDate properly set")
    XCTAssert(rateList.currentCurrency == .eur, "The rate list should have currentCurrency properly set")
    XCTAssert(rateList.list.count == historicalResponse.bpi.count, "The rate list should have list properly set")
  }
}
