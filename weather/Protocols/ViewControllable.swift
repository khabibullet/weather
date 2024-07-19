//
//  Protocols.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import UIKit

public protocol ViewControllable: AnyObject {
  var uiViewController: UIViewController { get }
}

extension ViewControllable where Self: UIViewController {
  public var uiViewController: UIViewController { self }
}
