//
//  RateTests.swift
//  BHKitTests
//
//  Created by Josep Bordes Jové on 01/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import XCTest
import BHKit

class RateTests: XCTestCase {
  
  var rate: Rate!
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    rate = nil
  }
  
  func testBasicInit() {
    // Given
    let date = Date()
    let rateFloat: Float = 1.1
    let currency = Currency.eur
    
    // When
    rate = Rate(date: date, rate: rateFloat, currency: currency)
    
    // Then
    XCTAssert(rate.date == date, "The rate should have date properly set")
    XCTAssert(rate.rate == rateFloat, "The rate should have rateFloat properly set")
    XCTAssert(rate.currency == currency, "The rate should have currency properly set")
  }
  
  func testInitFromDetailCurrentPriceResponse() {
    // Given
    let detailCurrentPriceResponse = DetailCurrentPriceResponse.fake
    let date = Date()

    // When
    rate = Rate(response: detailCurrentPriceResponse, date: date)
    
    // Then
    XCTAssert(rate.date == date, "The rate should have date properly set")
    XCTAssert(rate.rate == detailCurrentPriceResponse.rateFloat, "The rate should have rateFloat properly set")
    XCTAssert(rate.currency == Currency(rawValue: detailCurrentPriceResponse.code), "The rate should have currency properly set")
  }
  
  func testInitFromHistoricalResponse() {
    // Given
    let historicalResponse = HistoricalResponse.fake
    let dictionaryEntry = historicalResponse.bpi.first
    let currency = Currency.eur

    // When
    rate = Rate(response: historicalResponse, currency: currency)
    
    // Then
    XCTAssertNotNil(dictionaryEntry)
    XCTAssert(rate.date == Date.from(date: dictionaryEntry!.key, format: .short), "The rate should have date properly set")
    XCTAssert(rate.rate == dictionaryEntry!.value, "The rate should have rateFloat properly set")
    XCTAssert(rate.currency == currency, "The rate should have currency properly set")
  }
}
