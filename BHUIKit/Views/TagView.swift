//
//  TagView.swift
//  BHUIKit
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit

public class TagView: UIView {
  public var color: UIColor? {
    didSet {
      backgroundColor = color
    }
  }
  
  public var tagText: String? {
    didSet {
      tagLabel.text = tagText
    }
  }
  
  private lazy var tagLabel: UILabel = {
    let label = UILabel()
    label.lineBreakMode = .byTruncatingMiddle
    label.textAlignment = .center
    label.font = Font.tagText
    label.adjustsFontSizeToFitWidth = true
    label.textColor = Color.tagText
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    setupConstraints()
  }
  
  public override func draw(_ rect: CGRect) {
    self.layer.cornerRadius = rect.height / 2
    self.layoutSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    clipsToBounds = true
    addSubview(tagLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      heightAnchor.constraint(equalToConstant: 20),

      tagLabel.topAnchor.constraint(equalTo: topAnchor),
      tagLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      tagLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
    ])
  }
}
