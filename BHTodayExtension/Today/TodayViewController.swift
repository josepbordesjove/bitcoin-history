//
//  TodayViewController.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 30/11/2019.
//  Copyright (c) 2019 Josep Bordes Jové. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import NotificationCenter
import BHUIKit
import BHKit

protocol TodayDisplayLogic: class {
  func displayView(viewModel: Today.PrepareView.ViewModel)
  func displayStartListening(viewModel: Today.StartListening.ViewModel)
  func displayStopListening(viewModel: Today.StopListening.ViewModel)
}

class TodayViewController: UIViewController, NCWidgetProviding, TodayDisplayLogic {
  var interactor: TodayBusinessLogic?
  
  // MARK: UI
  
  private lazy var activityView: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.isHidden = true
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()
  
  private lazy var loadingLabel: UILabel = {
    let label = UILabel()
    label.text = NSLocalizedString("Loading", comment: "")
    label.isHidden = true
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()
  
  private lazy var bitcoinInfoPriceLabel: UILabel = {
    let label = UILabel()
    label.isHidden = true
    label.font = Font.smallInfoText
    label.textColor = Color.extraInfoText
    label.text = NSLocalizedString("Bitcoin exchange rate", comment: "")
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()
  
  private lazy var bitcoinRateLabel: UILabel = {
    let label = UILabel()
    label.isHidden = true
    label.font = Font.bigInfoText
    label.textColor = Color.infoText
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()
  
  private lazy var lastUpdatedDateLabel: UILabel = {
    let label = UILabel()
    label.isHidden = true
    label.font = Font.extraInfoText
    label.textColor = Color.extraInfoText
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()
  
  private lazy var tagView: TagView = {
    let view = TagView()
    view.color = Color.brand
    view.isHidden = true
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = TodayInteractor()
    let presenter = TodayPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
    
    prepareView()
  }
  
  // MARK: Setup methods
  
  private func setupView() {
    [activityView, loadingLabel, lastUpdatedDateLabel, bitcoinRateLabel, bitcoinInfoPriceLabel, tagView].forEach { view.addSubview($0) }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 5),

      loadingLabel.centerYAnchor.constraint(equalTo: activityView.centerYAnchor),
      loadingLabel.leftAnchor.constraint(equalTo: activityView.rightAnchor, constant: 2),

      lastUpdatedDateLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
      lastUpdatedDateLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),

      bitcoinInfoPriceLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -1),
      bitcoinInfoPriceLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),

      bitcoinRateLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
      bitcoinRateLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 1),

      tagView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      tagView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
    ])
  }
  
  // MARK: Prepare view
  
  func prepareView() {
    activityView.isHidden = false
    loadingLabel.isHidden = false
    activityView.startAnimating()

    let request = Today.PrepareView.Request()
    interactor?.prepareView(request: request)
  }
  
  func displayView(viewModel: Today.PrepareView.ViewModel) {
    handleResult(result: viewModel.result)
    startListening()
  }
  
  // MARK: Start listening for updates
  
  private func startListening() {
    let request = Today.StartListening.Request()
    interactor?.startListening(request: request)
  }
  
  func displayStartListening(viewModel: Today.StartListening.ViewModel) {
    handleResult(result: viewModel.result)
  }
  
  // MARK: Stop listening for updates
  
  private func stopListening() {
    let request = Today.StopListening.Request()
    interactor?.stopListening(request: request)
  }
  
  func displayStopListening(viewModel: Today.StopListening.ViewModel) {
    // Handle
  }

  // MARK: Helpers
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    completionHandler(NCUpdateResult.newData)
  }
  
  func handleResult(result: Result<RateList, Error>) {
    switch result {
    case .success(let priceDetail):
      activityView.stopAnimating()
      activityView.isHidden = true
      loadingLabel.isHidden = true
      lastUpdatedDateLabel.text = priceDetail.updatedDate.toFormattedString(format: .long)
      lastUpdatedDateLabel.isHidden = false
      
      let localeRate = priceDetail.list.first { $0.currency == priceDetail.currentCurrency }
      bitcoinRateLabel.isHidden = false
      bitcoinRateLabel.text = localeRate?.rateLocaleFormatted
      bitcoinInfoPriceLabel.isHidden = false
      tagView.tagText = localeRate?.currency.rawValue
      tagView.isHidden = false
    case .failure:
      // TODO: Handle the error
      break
    }
  }
}
