//
//  BitcoinHistoryClientTests.swift
//  BHKitTests
//
//  Created by Josep Bordes Jové on 01/12/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import XCTest
import BHKit

class BitcoinHistoryClientTests: XCTestCase {
  
  var sut: APIClient!
  
  override func setUp() {
    
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  // MARK: Tests
  
  func testURLRequestGeneration() {
    // Given
    sut = BitcoinHistoryClient(loader: MemLoader())
    let endpoint: CoinDeskEndpoint = .currentPrice
    let url = "https://api.coindesk.com/v1/bpi/currentprice.json"

    // When
    let urlRequest = sut.urlRequest(from: endpoint)
    
    // Then
    XCTAssert(url == urlRequest?.url?.absoluteString, "The absoulte url must be equal")
  }
}
