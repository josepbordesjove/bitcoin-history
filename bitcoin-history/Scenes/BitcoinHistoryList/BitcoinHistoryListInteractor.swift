//
//  BitcoinHistoryListInteractor.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright (c) 2019 Josep Bordes Jové. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import BHKit

protocol BitcoinHistoryListBusinessLogic {
  func prepareView(request: BitcoinHistoryList.PrepareView.Request)
  func startUpdatingTodayRate(request: BitcoinHistoryList.StartUpdatingForPrice.Request)
  func stopUpdatingTodayRate(request: BitcoinHistoryList.StopUpdatingForPrice.Request)
  func forceUpdateTodaysRate(request: BitcoinHistoryList.ForceUpdateTodaysRate.Request)
}

protocol BitcoinHistoryListDataStore {
  var historicalList: RateList? { get set }
  var todayRate: RateList? { get set }
}

class BitcoinHistoryListInteractor: BitcoinHistoryListBusinessLogic, BitcoinHistoryListDataStore {
  struct Constants {
    static let refreshTodayRateInterval: Double = 60
    static let previousDaysToFetch: Int = 14
  }

  var presenter: BitcoinHistoryListPresentationLogic?
  
  // MARK: Data store
  
  var historicalList: RateList?
  var todayRate: RateList?
  
  // MARK: Private attributes
  
  let initialHistoricDate = Date(substractingDays: Constants.previousDaysToFetch)
  let finalHistoricDate = Date()
  
  // MARK: Workers
  
  var worker: Worker
  
  // MARK: Object lifecycle
  
  init(store: StoreProtocol = Store()) {
    worker = Worker(store: store)
  }
  
  // MARK: Business logic
  
  func prepareView(request: BitcoinHistoryList.PrepareView.Request) {
    // Make an initial presentation to show the placeholders
    let response = BitcoinHistoryList.PrepareView.Response(historicalList: historicalList, todayRate: todayRate, error: nil)
    presenter?.presentView(response: response)
    
    worker.getCurrentPrice { [weak self] (result) in
      switch result {
      case .success(let todayRate):
        self?.todayRate = todayRate
        let response = BitcoinHistoryList.PrepareView.Response(historicalList: self?.historicalList, todayRate: self?.todayRate, error: nil)
        self?.presenter?.presentView(response: response)
      case .failure(let error):
        let response = BitcoinHistoryList.PrepareView.Response(historicalList: self?.historicalList, todayRate: self?.todayRate, error: error)
        self?.presenter?.presentView(response: response)
      }
    }
    
    worker.getHistorical(start: initialHistoricDate, end: finalHistoricDate) { [weak self] (result) in
      switch result {
      case .success(let historicalList):
        self?.historicalList = historicalList
        let response = BitcoinHistoryList.PrepareView.Response(historicalList: self?.historicalList, todayRate: self?.todayRate, error: nil)
        self?.presenter?.presentView(response: response)
      case .failure(let error):
        let response = BitcoinHistoryList.PrepareView.Response(historicalList: self?.historicalList, todayRate: self?.todayRate, error: error)
        self?.presenter?.presentView(response: response)
      }
    }
  }
  
  func startUpdatingTodayRate(request: BitcoinHistoryList.StartUpdatingForPrice.Request) {
    worker.startListeningForTodayUpdates(timeIntervalToRefresh: Constants.refreshTodayRateInterval) { [weak self] (result) in
      switch result {
      case .success(let todayRate):
        self?.todayRate = todayRate
        let response = BitcoinHistoryList.StartUpdatingForPrice.Response(
          historicalList: self?.historicalList,
          todayRate: self?.todayRate,
          error: nil
        )
        self?.presenter?.presentStartUpdatingTodayRate(response: response)
      case .failure(let error):
        let response = BitcoinHistoryList.StartUpdatingForPrice.Response(
          historicalList: self?.historicalList,
          todayRate: self?.todayRate,
          error: error
        )
        self?.presenter?.presentStartUpdatingTodayRate(response: response)
      }
    }
  }
  
  func stopUpdatingTodayRate(request: BitcoinHistoryList.StopUpdatingForPrice.Request) {
    worker.stopListeningForTodayUpdates()
  }
  
  func forceUpdateTodaysRate(request: BitcoinHistoryList.ForceUpdateTodaysRate.Request) {
    worker.getCurrentPrice { [weak self] (result) in
      switch result {
      case .success(let todayRate):
        self?.todayRate = todayRate
        let response = BitcoinHistoryList.ForceUpdateTodaysRate.Response(historicalList: self?.historicalList, todayRate: self?.todayRate, error: nil)
        self?.presenter?.presentForceUpdateTodaysRate(response: response)
      case .failure(let error):
        let response = BitcoinHistoryList.ForceUpdateTodaysRate.Response(historicalList: self?.historicalList, todayRate: self?.todayRate, error: error)
        self?.presenter?.presentForceUpdateTodaysRate(response: response)
      }
    }
    
    worker.getHistorical(start: initialHistoricDate, end: finalHistoricDate) { [weak self] (result) in
      switch result {
      case .success(let historicalList):
        self?.historicalList = historicalList
        let response = BitcoinHistoryList.ForceUpdateTodaysRate.Response(historicalList: self?.historicalList, todayRate: self?.todayRate, error: nil)
        self?.presenter?.presentForceUpdateTodaysRate(response: response)
      case .failure(let error):
        let response = BitcoinHistoryList.ForceUpdateTodaysRate.Response(historicalList: self?.historicalList, todayRate: self?.todayRate, error: error)
        self?.presenter?.presentForceUpdateTodaysRate(response: response)
      }
    }
  }
}
