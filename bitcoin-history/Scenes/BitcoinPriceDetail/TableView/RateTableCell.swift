//
//  RateTableCell.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 30/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHKit
import BHUIKit

class RateTableCell: UITableViewCell, CellIdentifier {
  static let identifier = "rateTableCellId"
  
  // MARK: UI
  
  private lazy var tagView: TagView = {
    let view = TagView()
    view.color = Color.brand
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
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
  
  public func setup(with currencyDetail: CurrencyDetail) {
    rateLabel.text = currencyDetail.rateLocaleFormatted
    tagView.tagText = currencyDetail.code
  }
  
  private func setupView() {
    [rateLabel, tagView].forEach { addSubview($0) }
    selectionStyle = .none
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tagView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      tagView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),

      rateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      rateLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
    ])
  }
}
