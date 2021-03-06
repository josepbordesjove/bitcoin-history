//
//  BitcoinHistoryListPresenter.swift
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

protocol BitcoinHistoryListPresentationLogic {
  func presentView(response: BitcoinHistoryList.PrepareView.Response)
  func presentStartUpdatingTodayRate(response: BitcoinHistoryList.StartUpdatingForPrice.Response)
  func presentForceUpdateTodaysRate(response: BitcoinHistoryList.ForceUpdateTodaysRate.Response)
}

class BitcoinHistoryListPresenter: BitcoinHistoryListPresentationLogic {
  weak var viewController: BitcoinHistoryListDisplayLogic?
  
  func presentView(response: BitcoinHistoryList.PrepareView.Response) {
    let title = NSLocalizedString("Price history", comment: "This is the main title of the scene")
    
    let result = listResponseToResult(response)
    let viewModel = BitcoinHistoryList.PrepareView.ViewModel(title: title, result: result)
    viewController?.displayView(viewModel: viewModel)
  }
  
  func presentStartUpdatingTodayRate(response: BitcoinHistoryList.StartUpdatingForPrice.Response) {
    let result = listResponseToResult(response)
    let viewModel = BitcoinHistoryList.StartUpdatingForPrice.ViewModel(result: result)
    viewController?.displayStartUpdatingTodayRate(viewModel: viewModel)
  }
  
  func presentForceUpdateTodaysRate(response: BitcoinHistoryList.ForceUpdateTodaysRate.Response) {
    let result = listResponseToResult(response)
    let viewModel = BitcoinHistoryList.ForceUpdateTodaysRate.ViewModel(result: result)
    viewController?.displayForceUpdateTodaysRate(viewModel: viewModel)
  }
  
  // MARK: Helpers
  
  private func listResponseToResult(_ response: ListResponse) -> Result<[BitconHistorySection], Error> {
    if let error = response.error {
      return .failure(error)
    }
    
    if let todayRate = response.todayRate, let historicalList = response.historicalList {
      // Everything is loaded
      let sortedHistoricalList = sortHistorical(rateList: historicalList)
      return .success([.today(detail: todayRate), .historic(list: sortedHistoricalList)])
    } else if let todayRate = response.todayRate {
      // Only the today rate is loaded
      return .success([.today(detail: todayRate), .placeholder(amount: BitcoinHistoryListInteractor.Constants.previousDaysToFetch)])
    } else if let historicalList = response.historicalList {
      // Only the historic list is loaded
      let sortedHistoricalList = sortHistorical(rateList: historicalList)
      return .success([.placeholder(amount: 1), .historic(list: sortedHistoricalList)])
    } else {
      // Anything has been loaded yet
      return .success([.placeholder(amount: BitcoinHistoryListInteractor.Constants.previousDaysToFetch)])
    }
  }
  
  private func sortHistorical(rateList: RateList) -> RateList {
    return RateList(
      disclaimer: rateList.disclaimer,
      updatedDate: rateList.updatedDate,
      currentCurrency: rateList.currentCurrency,
      list: rateList.list.sorted { $0.date > $1.date }
    )
  }
}
