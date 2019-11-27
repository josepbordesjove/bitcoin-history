//
//  BitcoinPriceDetailViewController.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 27/11/2019.
//  Copyright (c) 2019 Josep Bordes Jové. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BitcoinPriceDetailDisplayLogic: class {
  func displaySomething(viewModel: BitcoinPriceDetail.Something.ViewModel)
}

class BitcoinPriceDetailViewController: UITableViewController, BitcoinPriceDetailDisplayLogic {
  var interactor: BitcoinPriceDetailBusinessLogic?
  var router: (NSObjectProtocol & BitcoinPriceDetailRoutingLogic & BitcoinPriceDetailDataPassing)?

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
    let interactor = BitcoinPriceDetailInteractor()
    let presenter = BitcoinPriceDetailPresenter()
    let router = BitcoinPriceDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    
    doSomething()
  }
  
  // MARK: Setup methods
  
  private func setupView() {
    title = NSLocalizedString("Price detail", comment: "This is the main title of the scene")
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething() {
    let request = BitcoinPriceDetail.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: BitcoinPriceDetail.Something.ViewModel) {
    //nameTextField.text = viewModel.name
  }
}
