//
//  BitcoinHistoryTableHandler.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHKit

protocol BitcoinHistoryTableHandlerDelegate: class {
  func didSelectRow(at indexPath: IndexPath)
}

class BitcoinHistoryTableHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
  private(set) var sections: [BitconHistorySection]
  weak var tableView: UITableView?
  weak var delegate: BitcoinHistoryTableHandlerDelegate?
  
  // MARK: Object lifecycle
  
  init(sections: [BitconHistorySection], tableView: UITableView) {
    self.sections = sections
    self.tableView = tableView
    super.init()
    
    registerCells()

    self.tableView?.dataSource = self
    self.tableView?.delegate = self
    self.tableView?.reloadData()
  }
  
  // MARK: Private methods
  
  private func registerCells() {
    tableView?.register(cell: HistoryTableCell.self)
    tableView?.register(cell: TodayTableCell.self)
    tableView?.register(cell: PlaceholderCell.self)
  }
  
  // MARK: Public methods

  public func update(sections: [BitconHistorySection]) {
    self.sections = sections
    
    let tableSelectedRows = tableView?.indexPathsForSelectedRows ?? []

    tableView?.reloadData()

    tableSelectedRows.forEach { (indexPathSelected) in
      tableView?.selectRow(at: indexPathSelected, animated: false, scrollPosition: .none)
    }
  }
  
  // MARK: Table view data source
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch sections[section] {
    case .today:
      return 1
    case .historic(let list):
      return list.list.count
    case .placeholder(let amount):
      return amount
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch sections[indexPath.section] {
    case .today(let detail):
      let cell = tableView.dequeue(cell: TodayTableCell.self, indexPath: indexPath)
      cell.setup(with: detail)
      return cell
    case .historic(let list):
      let cell = tableView.dequeue(cell: HistoryTableCell.self, indexPath: indexPath)
      let historicRate = list.list[indexPath.row]
      cell.setup(with: historicRate.date.toFormattedString(), rateFormatted: historicRate.rateLocaleFormatted, currency: historicRate.currency)
      return cell
    case .placeholder:
      let cell = tableView.dequeue(cell: PlaceholderCell.self, indexPath: indexPath)
      cell.startActivity()
      return cell
    }
  }
  
  // MARK: Table view delegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch sections[indexPath.section] {
    case .placeholder:
      return 80
    default:
      return UITableView.automaticDimension
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch sections[indexPath.section] {
    case .placeholder:
      break
    default:
      delegate?.didSelectRow(at: indexPath)
    }
  }
}
