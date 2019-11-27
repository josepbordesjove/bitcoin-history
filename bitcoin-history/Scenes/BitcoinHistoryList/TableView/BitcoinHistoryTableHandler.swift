//
//  BitcoinHistoryTableHandler.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHKit

class BitcoinHistoryTableHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
  private(set) var historicalList: HistoricalList
  weak var tableView: UITableView?
  
  init(historicalList: HistoricalList, tableView: UITableView) {
    self.historicalList = historicalList
    self.tableView = tableView
    super.init()
    
    registerCells()

    self.tableView?.dataSource = self
    self.tableView?.delegate = self
    self.tableView?.reloadData()
  }
  
  // MARK: Private methods
  
  private func registerCells() {
    tableView?.register(HistoryTableCell.self, forCellReuseIdentifier: HistoryTableCell.identifier)
  }
  
  // MARK: Public methods

  public func update(historicalList: HistoricalList) {
    self.historicalList = historicalList
    self.tableView?.reloadData()
  }
  
  // MARK: Table view data source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return historicalList.historicRates.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableCell.identifier, for: indexPath) as? HistoryTableCell else {
      assertionFailure("The cell must be always dequeueable")
      return UITableViewCell()
    }
    
    let historicRate = historicalList.historicRates[indexPath.row]
    cell.setup(with: historicRate.date, rate: historicRate.rate)

    return cell
  }
  
  // MARK: Table view delegate
}
