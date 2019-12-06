//
//  TodayTableCell.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 28/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHKit
import BHUIKit

class TodayTableCell: UITableViewCell, CellIdentifier {
  static let identifier = "todayTableCellId"
  
  // MARK: UI
  
  private lazy var todayLabel: UILabel = {
    let label = UILabel()
    label.font = Font.extraInfoText
    label.textColor = Color.brand
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private lazy var todayImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = Icon.star?.tint(with: Color.brand)
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
  
  private lazy var rateLabel: UILabel = {
    let label = UILabel()
    label.font = Font.rateInfoText
    label.textColor = Color.infoText
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private lazy var tagView: TagView = {
    let view = TagView()
    view.color = Color.brand
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private lazy var updatedLabel: UILabel = {
    let label = UILabel()
    label.alpha = 0
    label.font = Font.extraInfoText
    label.textColor = Color.extraInfoText
    label.text = NSLocalizedString("Updated right now", comment: "")
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  // MARK: Object life cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup methods
  
  public func setup(with detail: RateList) {
    let localeRate = detail.list.first { $0.currency == detail.currentCurrency }
    
    self.rateLabel.text = localeRate?.rateLocaleFormatted
    self.tagView.tagText = localeRate?.currency.rawValue
    self.todayLabel.text = NSLocalizedString("Today", comment: "") + " (\(detail.updatedDate.toFormattedString(format: .hour)))"
  }
  
  private func setupView() {
    [todayLabel, todayImageView, rateLabel, tagView, updatedLabel].forEach { addSubview($0) }
    accessoryType = .disclosureIndicator
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      rateLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      rateLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -1),
      rateLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      
      todayImageView.topAnchor.constraint(equalTo: centerYAnchor, constant: 3),
      todayImageView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      todayImageView.heightAnchor.constraint(equalToConstant: 20),
      todayImageView.widthAnchor.constraint(equalToConstant: 20),
      
      todayLabel.centerYAnchor.constraint(equalTo: todayImageView.centerYAnchor),
      todayLabel.leftAnchor.constraint(equalTo: todayImageView.rightAnchor, constant: 2),
      
      tagView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      tagView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -30),
      
      updatedLabel.rightAnchor.constraint(equalTo: tagView.rightAnchor),
      updatedLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
    ])
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    if selected {
      todayImageView.image = Icon.star?.tint(with: .lightGray)
      todayLabel.textColor = .lightGray
    } else {
      todayImageView.image = Icon.star?.tint(with: Color.brand)
      todayLabel.textColor = Color.brand
    }
  }
}
