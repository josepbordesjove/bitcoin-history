//
//  BitcoinPriceDetailTableHandler.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHKit

class BitcoinPriceDetailTableHandler: NSObject, UITableViewDataSource {
  private(set) var currencyDetails: [Rate]
  weak var tableView: UITableView?
  
  // MARK: Object lifecycle
  
  init(currencyDetails: [Rate], tableView: UITableView) {
    self.currencyDetails = currencyDetails
    self.tableView = tableView
    super.init()
    
    registerCells()

    self.tableView?.dataSource = self
    self.tableView?.reloadData()
  }
  
  // MARK: Private methods
  
  private func registerCells() {
    tableView?.register(cell: RateTableCell.self)
  }
  
  // MARK: Public methods

  public func update(currencyDetails: [Rate]) {
    self.currencyDetails = currencyDetails
    self.tableView?.reloadData()
  }
  
  // MARK: Table view data source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencyDetails.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(cell: RateTableCell.self, indexPath: indexPath)
    cell.setup(with: currencyDetails[indexPath.row])
    return cell
  }
}
