//
//  LocaleManagerTests.swift
//  BHKitTests
//
//  Created by Josep Bordes Jové on 01/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import XCTest
@testable import BHKit

class LocaleManagerTests: XCTestCase {
  
  var sut: LocaleManager!
  
  override func setUp() {
    sut = LocaleManager()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testConvertToFormattedeCurrency() {
    // Given
    let rate: Float = 12
    let formattedRate = sut.convertToFormattedCurrency(rate, currency: .eur)
    
    // When
    
    // Then
    XCTAssert("\(rate)" != formattedRate, "The formatted rate must be formatted")
  }
  
  func testDeviceLocaleCurrency() {
    // Given
    let code = Locale.current.currencyCode
    let localeCurrency = sut.deviceLocaleCurrency()

    // When
    
    // Then
    if let code = code {
      XCTAssert(localeCurrency.rawValue == code, "Should retrieve the locale currency code properly")
    } else {
      XCTAssert(localeCurrency.rawValue == Currency.usd.rawValue, "Should fallback tu USD if no locale is available")
    }
  }
}

