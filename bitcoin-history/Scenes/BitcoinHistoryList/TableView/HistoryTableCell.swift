//
//  HistoryTableCell.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 28/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHKit

class HistoryTableCell: UITableViewCell {
  static let identifier = "historyTableCellId"

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup
  
  public func setup(with date: String, rate: Float) {
    self.textLabel?.text = "\(rate)"
    self.detailTextLabel?.text = date
  }
  
  private func setupView() {
    
  }
}
