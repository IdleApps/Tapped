//
//  TappedProducts.swift
//  Tapped
//
//  Created by Luke Cheskin on 13/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import Foundation

public struct TappedProducts {
  
    public static let RemovingAdverts = "com.IdleApps.Tapped.RemovingAds"
    public static let CustomWinValue = "com.IdleApps.Tapped.CustomWinValue"
  
  fileprivate static let productIdentifiers: Set<ProductIdentifier> = [TappedProducts.RemovingAdverts, TappedProducts.CustomWinValue]

  public static let store = IAPHelper(productIds: TappedProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
