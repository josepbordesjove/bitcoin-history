//
//  BitcoinPriceDetailPresenter.swift
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

protocol BitcoinPriceDetailPresentationLogic {
  func presentSomething(response: BitcoinPriceDetail.Something.Response)
}

class BitcoinPriceDetailPresenter: BitcoinPriceDetailPresentationLogic {
  weak var viewController: BitcoinPriceDetailDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: BitcoinPriceDetail.Something.Response) {
    let viewModel = BitcoinPriceDetail.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
