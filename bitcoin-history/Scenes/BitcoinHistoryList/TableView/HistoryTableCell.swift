//
//  HistoryTableCell.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 28/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHKit
import BHUIKit

class HistoryTableCell: UITableViewCell, CellIdentifier {
  static let identifier = "historyTableCellId"
  
  // MARK: UI
  
  private lazy var tagView: TagView = {
    let view = TagView()
    view.color = Color.brand
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()
  
  private lazy var dayLabel: UILabel = {
    let label = UILabel()
    label.font = Font.extraInfoText
    label.textColor = Color.extraInfoText
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()
  
  private lazy var rateLabel: UILabel = {
    let label = UILabel()
    label.font = Font.rateInfoText
    label.textColor = Color.infoText
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()
  
  // MARK: Object lifecycle

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup
  
  public func setup(with date: String, rateFormatted: String, currency: Currency) {
    rateLabel.text = rateFormatted
    dayLabel.text = date
    tagView.tagText = currency.rawValue
  }
  
  private func setupView() {
    accessoryType = .disclosureIndicator
    
    [dayLabel, rateLabel, tagView].forEach { addSubview($0) }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tagView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      tagView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -30),

      rateLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      rateLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      
      dayLabel.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 2),
      dayLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      dayLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
    ])
  }
}
