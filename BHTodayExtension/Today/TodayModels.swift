//
//  TodayModels.swift
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

enum Today {
  // MARK: Use cases
  
  enum PrepareView {
    struct Request {
    }
    struct Response {
      let result: Result<PriceDetail, Error>
    }
    struct ViewModel {
      let result: Result<PriceDetail, Error>
    }
  }
  
  enum StartListening {
    struct Request {
    }
    struct Response {
      let result: Result<PriceDetail, Error>
    }
    struct ViewModel {
      let result: Result<PriceDetail, Error>
    }
  }
  
  enum StopListening {
    struct Request {
    }
    struct Response {
    }
    struct ViewModel {
    }
  }
}