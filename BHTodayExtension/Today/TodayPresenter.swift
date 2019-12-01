//
//  TodayPresenter.swift
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

protocol TodayPresentationLogic {
  func prepareView(response: Today.PrepareView.Response)
  func presentStartListening(response: Today.StartListening.Response)
}

class TodayPresenter: TodayPresentationLogic {
  weak var viewController: TodayDisplayLogic?
  
  func prepareView(response: Today.PrepareView.Response) {
    let viewModel = Today.PrepareView.ViewModel(result: response.result)
    viewController?.displayView(viewModel: viewModel)
  }
  
  func presentStartListening(response: Today.StartListening.Response) {
    let viewModel = Today.StartListening.ViewModel(result: response.result)
    viewController?.displayStartListening(viewModel: viewModel)
  }
}
