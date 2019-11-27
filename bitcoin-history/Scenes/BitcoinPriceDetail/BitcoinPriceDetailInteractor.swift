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

protocol BitcoinPriceDetailBusinessLogic {
  func doSomething(request: BitcoinPriceDetail.Something.Request)
}

protocol BitcoinPriceDetailDataStore {
  //var name: String { get set }
}

class BitcoinPriceDetailInteractor: BitcoinPriceDetailBusinessLogic, BitcoinPriceDetailDataStore {
  var presenter: BitcoinPriceDetailPresentationLogic?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: BitcoinPriceDetail.Something.Request) {
    let response = BitcoinPriceDetail.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
