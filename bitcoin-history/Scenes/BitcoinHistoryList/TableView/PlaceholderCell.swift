//
//  PlaceholderCell.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 30/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit
import BHKit
import BHUIKit

class PlaceholderCell: UITableViewCell, CellIdentifier {
  static let identifier = "placeholderCellId"

  // MARK: UI
  
  private lazy var ratePlaceholderView: UIView = {
    let view = UIView()
    view.backgroundColor = Color.infoText
    view.layer.cornerRadius = 2
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()
  
  private lazy var datePlaceholderView: UIView = {
    let view = UIView()
    view.backgroundColor = Color.extraInfoText
    view.layer.cornerRadius = 2
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()
  
  private lazy var tagView: TagView = {
    let view = TagView()
    view.color = Color.brand
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    #if targetEnvironment(macCatalyst)
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    #else
    let activityIndicator = UIActivityIndicatorView(style: isDarkMode ? .white : .gray)
    #endif
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    return activityIndicator
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
  
  private func setupView() {
    [ratePlaceholderView, datePlaceholderView, tagView, activityIndicator].forEach { addSubview($0) }
    selectionStyle = .none
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      ratePlaceholderView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4),
      ratePlaceholderView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      ratePlaceholderView.heightAnchor.constraint(equalToConstant: 16),
      ratePlaceholderView.widthAnchor.constraint(equalToConstant: 120),
      
      datePlaceholderView.topAnchor.constraint(equalTo: centerYAnchor, constant: 4),
      datePlaceholderView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      datePlaceholderView.heightAnchor.constraint(equalToConstant: 12),
      datePlaceholderView.widthAnchor.constraint(equalToConstant: 60),
      
      tagView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      tagView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
      tagView.widthAnchor.constraint(equalToConstant: 40),
      
      activityIndicator.centerYAnchor.constraint(equalTo: tagView.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: tagView.centerXAnchor)
    ])
  }
  
  // MARK: Helpers
  
  public func startActivity() {
    activityIndicator.startAnimating()
  }
}
