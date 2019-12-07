//
//  PlaceholderView.swift
//  BHUIKit
//
//  Created by Josep Bordes Jové on 30/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit

public enum EmptyPlaceholderState: Equatable {
  case unknown
  case error(error: Error)
  case empty
  case loading(image: UIImage?)
  case loaded
  
  public static func == (lhs: EmptyPlaceholderState, rhs: EmptyPlaceholderState) -> Bool {
    switch lhs {
    case .error:
      switch rhs {
      case .error:
        return true
      default:
        return false
      }
    case .empty:
      switch rhs {
      case .empty:
        return true
      default:
        return false
      }
    case .loaded:
      switch rhs {
      case .loaded:
        return true
      default:
        return false
      }
    case .loading:
      switch rhs {
      case .loading:
        return true
      default:
        return false
      }
    case .unknown:
      switch rhs {
      case .unknown:
        return true
      default:
        return false
      }
    }
  }
}

public class PlaceholderView: UIView {
  
  // MARK: State
  
  public var state: EmptyPlaceholderState {
    didSet {
      setupForState()
    }
  }
  
  // MARK: Private vars
  
  private weak var viewToHideWhenLoaded: UIView?
  
  // MARK: Setable properties
  
  let isDarkMode: Bool
  
  private(set) var shouldDisplayCallToAction: Bool = false {
    didSet {
      callToActionButton.isHidden = !shouldDisplayCallToAction
    }
  }
  
  // MARK: UI
  
  public lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = Font.bigInfoText
    label.textColor = Color.brand
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  public lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = Font.extraInfoText
    label.textColor = Color.secondary
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private(set) lazy var callToActionButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = Color.brand
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 8
    button.titleLabel?.font = Font.ctaText
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  private(set) lazy var activityIndicator: UIActivityIndicatorView = {
    #if targetEnvironment(macCatalyst)
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    #else
    let indicator = UIActivityIndicatorView(style: isDarkMode ? .white : .gray)
    #endif

    indicator.startAnimating()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    
    return indicator
  }()
  
  // MARK: Object lifecycle
  
  public init(state: EmptyPlaceholderState, viewToHideWhenLoaded: UIView, isDarkMode: Bool) {
    self.state = state
    self.viewToHideWhenLoaded = viewToHideWhenLoaded
    self.isDarkMode = isDarkMode
    super.init(frame: .zero)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Public methods
  
  public func set(state: EmptyPlaceholderState) {
    self.state = state
  }
  
  public func setup(callToActionTitle: String? = nil, callToAction: Selector? = nil, target: Any? = nil) {
    if let callToActionTitle = callToActionTitle, let callToAction = callToAction, let target = target {
      callToActionButton.addTarget(target, action: callToAction, for: .touchUpInside)
      callToActionButton.setTitle(callToActionTitle, for: .normal)
    } else {
      callToActionButton.isHidden = true
    }
  }
  
  public func setup(title: String, description: String?, callToActionTitle: String? = nil, callToAction: Selector? = nil, target: Any? = nil) {
    titleLabel.text = title
    
    if let description = description {
      descriptionLabel.text = description
      descriptionLabel.isHidden = false
    } else {
      descriptionLabel.isHidden = true
    }
    
    setup(callToActionTitle: callToActionTitle, callToAction: callToAction, target: target)
  }
  
  public func shouldDisplayCallToAction(_ shouldDisplay: Bool) {
    self.shouldDisplayCallToAction = shouldDisplay
  }
  
  // MARK: Private methods
  
  private func setupForState() {
    switch state {
    case .unknown:
      prepareForUnknown()
    case .error(let error):
      prepareForError(error: error)
    case .loaded:
      prepareForLoaded()
    case .empty:
      prepareForEmpty()
    case .loading(let image):
      prepareForLoading(image: image)
    }
  }
  
  private func setupView() {
    var placeholderTopConstant: CGFloat = 0
    var placeholderBottomConstant: CGFloat = 0
    
    // Add the placeholder view to the content view and prepare the constraints
    if let viewToHideWhenLoaded = viewToHideWhenLoaded, let viewToHideWhenLoadedSuperview = viewToHideWhenLoaded.superview {
      if let viewToHideWhenLoadedTable = viewToHideWhenLoaded as? UITableView {
        // Adjust to header and top
        if let headerView = viewToHideWhenLoadedTable.tableHeaderView {
          placeholderTopConstant = headerView.frame.height + viewToHideWhenLoadedTable.contentInset.top
        } else {
          placeholderTopConstant = viewToHideWhenLoadedTable.contentInset.top
        }
        
        // Adjust to footer and top
        if let footerView = viewToHideWhenLoadedTable.tableFooterView {
          placeholderBottomConstant = footerView.frame.height + viewToHideWhenLoadedTable.contentInset.bottom
        } else {
          placeholderBottomConstant = viewToHideWhenLoadedTable.contentInset.bottom
        }
      }
      viewToHideWhenLoadedSuperview.addSubview(self)
      
      NSLayoutConstraint.activate([
        self.topAnchor.constraint(equalTo: viewToHideWhenLoaded.topAnchor, constant: placeholderTopConstant),
        self.leftAnchor.constraint(equalTo: viewToHideWhenLoaded.leftAnchor),
        self.rightAnchor.constraint(equalTo: viewToHideWhenLoaded.rightAnchor),
        self.bottomAnchor.constraint(equalTo: viewToHideWhenLoaded.bottomAnchor, constant: -placeholderBottomConstant)
      ])
    }
    
    [titleLabel, descriptionLabel, callToActionButton, activityIndicator].forEach { addSubview($0) }
    backgroundColor = .clear
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
      titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
      
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
      descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
      descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
      
      callToActionButton.heightAnchor.constraint(equalToConstant: 44),
      callToActionButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
      callToActionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
      callToActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
      
      activityIndicator.widthAnchor.constraint(equalToConstant: 30),
      activityIndicator.heightAnchor.constraint(equalToConstant: 30),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
  
  // MARK: Helpers
  
  private func prepareForLoaded() {
    self.isHidden = true
    viewToHideWhenLoaded?.isHidden = false
    
    titleLabel.isHidden = true
    descriptionLabel.isHidden = true
    callToActionButton.isHidden = !shouldDisplayCallToAction
    
    activityIndicator.startAnimating()
    activityIndicator.isHidden = false
  }
  
  private func prepareForLoading(image: UIImage?) {
    self.isHidden = false
    viewToHideWhenLoaded?.isHidden = true
    
    titleLabel.isHidden = true
    descriptionLabel.isHidden = true
    callToActionButton.isHidden = true
    
    activityIndicator.startAnimating()
    activityIndicator.isHidden = false
  }
  
  private func prepareForEmpty() {
    self.isHidden = false
    viewToHideWhenLoaded?.isHidden = true
    
    titleLabel.isHidden = false
    descriptionLabel.isHidden = false
    callToActionButton.isHidden = !shouldDisplayCallToAction
    
    activityIndicator.stopAnimating()
    activityIndicator.isHidden = true
  }
  
  private func prepareForError(error: Error) {
    self.isHidden = false
    viewToHideWhenLoaded?.isHidden = true
    
    titleLabel.isHidden = false
    titleLabel.text = NSLocalizedString("Something bad happened", comment: "")
    
    descriptionLabel.isHidden = false
    descriptionLabel.text = error.localizedDescription
    
    callToActionButton.isHidden = !shouldDisplayCallToAction
  }
  
  private func prepareForUnknown() {
      self.isHidden = true
      viewToHideWhenLoaded?.isHidden = false
  }
}
