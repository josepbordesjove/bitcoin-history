//
//  UITableView+.swift
//  bitcoin-history
//
//  Created by Josep Bordes Jové on 29/11/2019.
//  Copyright © 2019 Josep Bordes Jové. All rights reserved.
//

import UIKit

extension UITableView {
    // MARK: Register cells
    
    func register<R: CellIdentifier & UITableViewCell>(cell: R.Type) {
        self.register(R.self, forCellReuseIdentifier: R.identifier)
    }
    
    // MARK: Dequeue cells
    
    func dequeue<R: CellIdentifier & UITableViewCell>(cell: R.Type, indexPath: IndexPath) -> R {
      if let cell = self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? R {
        return cell
      } else {
        fatalError("A cell must be always dequeueable")
      }
    }
}
