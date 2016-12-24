//
//  MasterViewController.swift
//  Tapped
//
//  Created by Luke Cheskin on 13/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import StoreKit

class MasterViewController: UITableViewController {
  
  var products = [SKProduct]()
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Purchase"
    
    
    
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(MasterViewController.reload), for: .valueChanged)
    
    let backButton = UIBarButtonItem(title: "Back",
                                     style: .plain,
                                     target: self,
                                     action: #selector(MasterViewController.backTapped))
    navigationItem.leftBarButtonItem = backButton
    
    let restoreButton = UIBarButtonItem(title: "Restore",
                                        style: .plain,
                                       target: self,
                                       action: #selector(MasterViewController.restoreTapped(_:)))
    navigationItem.rightBarButtonItem = restoreButton
    
    NotificationCenter.default.addObserver(self, selector: #selector(MasterViewController.handlePurchaseNotification(_:)),
                                                               name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
                                                             object: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    reload()
  }
  
  func reload() {
    products = []
    
    tableView.reloadData()
    
    TappedProducts.store.requestProducts{success, products in
      if success {
        self.products = products!
        
        self.tableView.reloadData()
      }
      
      self.refreshControl?.endRefreshing()
    }
  }
  
  func restoreTapped(_ sender: AnyObject) {
    TappedProducts.store.restorePurchases()
    print("Restore button tapped")
  }
    
    func backTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as UIViewController
        present(vc, animated: true)
    }

  func handlePurchaseNotification(_ notification: Notification) {
    guard let productID = notification.object as? String else { return }
    
    for (index, product) in products.enumerated() {
      guard product.productIdentifier == productID else { continue }
      
      tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
  }
}

// MARK: - UITableViewDataSource

extension MasterViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
    
    let product = products[(indexPath as NSIndexPath).row]
    
    
    cell.product = product
    cell.buyButtonHandler = { product in
      TappedProducts.store.buyProduct(product)
    }
    
    return cell
  }
}
