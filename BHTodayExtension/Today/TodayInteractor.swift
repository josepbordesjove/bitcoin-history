//
//  TodayInteractor.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 30/11/2019.
//  Copyright (c) 2019 Josep Bordes Jové. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import BHKit
protocol TodayBusinessLogic {
  func prepareView(request: Today.PrepareView.Request)
  func startListening(request: Today.StartListening.Request)
  func stopListening(request: Today.StopListening.Request)
}

protocol TodayDataStore {
  var detail: RateList? { get set }
}

class TodayInteractor: TodayBusinessLogic, TodayDataStore {
  var presenter: TodayPresentationLogic?
  var timer: Timer?
  
  // MARK: Data store
  
  var detail: RateList?
  
  // MARK: Workers
  
  var worker = Worker(store: Store())
  
  // MARK: Business logic
  
  func prepareView(request: Today.PrepareView.Request) {
    worker.getCurrentPrice { (result) in
      let response = Today.PrepareView.Response(result: result)
      self.presenter?.prepareView(response: response)
    }
  }
  
  func startListening(request: Today.StartListening.Request) {
    if timer != nil {
      return
    }
    
    let timeIntervalToRefresh: Double = 10

    timer = Timer.scheduledTimer(withTimeInterval: timeIntervalToRefresh, repeats: true) { (_) in
      self.worker.getCurrentPrice { (result) in
        let response = Today.StartListening.Response(result: result)
        self.presenter?.presentStartListening(response: response)
      }
    }
  }
  
  func stopListening(request: Today.StopListening.Request) {
    timer?.invalidate()
    timer = nil
    
    let response = Today.StopListening.Response()
    presenter?.presentStopListening(response: response)
  }
}
