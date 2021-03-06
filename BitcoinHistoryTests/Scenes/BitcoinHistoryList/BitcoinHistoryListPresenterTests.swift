//
//  BitcoinHistoryListPresenterTests.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 30/11/2019.
//  Copyright (c) 2019 Josep Bordes Jové. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Bitcoin_History
import XCTest
import BHKit

class BitcoinHistoryListPresenterTests: XCTestCase {
  // MARK: Subject under test
  
  var sut: BitcoinHistoryListPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupBitcoinHistoryListPresenter()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupBitcoinHistoryListPresenter() {
    sut = BitcoinHistoryListPresenter()
  }
  
  // MARK: Test doubles
  
  class BitcoinHistoryListDisplayLogicSpy: BitcoinHistoryListDisplayLogic {
    var displayViewCalled = false
    var displayStartUpdatingTodayRateCalled = false
    var displayStopUpdatingTodayRateCalled = false
    var displayForceUpdateTodaysRateCalled = false
    
    var listIsSortedInViewModel = false
    var containsHistoricSection = false
    var containsTodaySection = false
    var containsPlaceholder = false
    var errorHappened = false
    
    func displayView(viewModel: BitcoinHistoryList.PrepareView.ViewModel) {
      displayViewCalled = true
      handle(result: viewModel.result)
    }
    
    func displayStartUpdatingTodayRate(viewModel: BitcoinHistoryList.StartUpdatingForPrice.ViewModel) {
      displayStartUpdatingTodayRateCalled = true
      handle(result: viewModel.result)
    }
    
    func displayStopUpdatingTodayRate(viewModel: BitcoinHistoryList.StopUpdatingForPrice.ViewModel) {
      displayStopUpdatingTodayRateCalled = true
    }
    
    func displayForceUpdateTodaysRate(viewModel: BitcoinHistoryList.ForceUpdateTodaysRate.ViewModel) {
      displayForceUpdateTodaysRateCalled = true
      handle(result: viewModel.result)
    }
    
    private func handle(result: Result<[BitconHistorySection], Error>) {
        switch result {
        case .success(let sections):
            sections.forEach { (section) in
                switch section {
                case .today:
                    containsTodaySection = true
                case .historic(let list):
                    containsHistoricSection = true
                    let sortedRateList = list.list.sorted { $0.date > $1.date }
                    listIsSortedInViewModel = sortedRateList == list.list
                case .placeholder:
                    containsPlaceholder = true
                }
            }
        case .failure:
            errorHappened = false
        }
    }
  }
  
  // MARK: Tests
  
  func testPresentView() {
    // Given
    let spy = BitcoinHistoryListDisplayLogicSpy()
    sut.viewController = spy
    let response = BitcoinHistoryList.PrepareView.Response(historicalList: RateList.fake, todayRate: RateList.fake, error: nil)
    
    // When
    sut.presentView(response: response)
    
    // Then
    XCTAssertTrue(spy.displayViewCalled, "presentView(response:) should ask the view controller to display the result")
    XCTAssertTrue(spy.containsTodaySection, "")
    XCTAssertTrue(spy.listIsSortedInViewModel, "")
    XCTAssertTrue(spy.containsHistoricSection, "")
  }
  
  func testDisplayStartUpdatingTodayRate(){
    // Given
    let spy = BitcoinHistoryListDisplayLogicSpy()
    sut.viewController = spy
    let response = BitcoinHistoryList.StartUpdatingForPrice.Response(historicalList: RateList.fake, todayRate: RateList.fake, error: nil)

    // When
    sut.presentStartUpdatingTodayRate(response: response)

    // Then
    XCTAssertTrue(spy.displayStartUpdatingTodayRateCalled, "presentStartUpdatingTodayRate(response:) should ask the view controller to display the result")
    XCTAssertTrue(spy.containsTodaySection, "")
    XCTAssertTrue(spy.listIsSortedInViewModel, "")
    XCTAssertTrue(spy.containsHistoricSection, "")
  }

  func testDisplayForceUpdateTodaysRate() {
    // Given
    let response = BitcoinHistoryList.ForceUpdateTodaysRate.Response(historicalList: RateList.fake, todayRate: nil, error: nil)
    let spy = BitcoinHistoryListDisplayLogicSpy()
    sut.viewController = spy
    
    // When
    sut.presentForceUpdateTodaysRate(response: response)
    
    // Then
    XCTAssertTrue(spy.displayForceUpdateTodaysRateCalled, "presentForceUpdateTodaysRate(response:) should ask the view controller to display the result")
    XCTAssertFalse(spy.containsTodaySection, "")
    XCTAssertTrue(spy.listIsSortedInViewModel, "")
    XCTAssertTrue(spy.containsHistoricSection, "")
  }
}
