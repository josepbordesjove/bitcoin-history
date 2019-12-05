//
//  BitcoinPriceDetailInteractor.swift
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

protocol BitcoinPriceDetailBusinessLogic {
  func prepareView(request: BitcoinPriceDetail.PrepareView.Request)
}

protocol BitcoinPriceDetailDataStore {
  var dayRate: RateList? { get set }
  var historicRate: Rate? { get set }
}

class BitcoinPriceDetailInteractor: BitcoinPriceDetailBusinessLogic, BitcoinPriceDetailDataStore {
  var presenter: BitcoinPriceDetailPresentationLogic?
  
  // MARK: Data store
  
  var dayRate: RateList?
  var historicRate: Rate?
  
  // MARK: Workers
  
  var worker: Worker
  
  // MARK: Object lifecycle
  
  init(store: StoreProtocol = Store()) {
    worker = Worker(store: store)
  }
  
  // MARK: Business logic
  
  func prepareView(request: BitcoinPriceDetail.PrepareView.Request) {
    if let dayRate = dayRate {
      let response = BitcoinPriceDetail.PrepareView.Response(result: .success(dayRate.list))
      presenter?.presentView(response: response)
      return
    }

    worker.getHistoricDetail(rate: historicRate) { [weak self] (result) in
      switch result {
      case .success(let priceDetail):
        self?.dayRate = priceDetail
        let response = BitcoinPriceDetail.PrepareView.Response(result: .success(priceDetail.list))
        self?.presenter?.presentView(response: response)
      case .failure(let error):
        let response = BitcoinPriceDetail.PrepareView.Response(result: .failure(error))
        self?.presenter?.presentView(response: response)
      }
    }
  }
}
