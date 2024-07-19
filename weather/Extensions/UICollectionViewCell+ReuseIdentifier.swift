//
//  UICollectionViewCell+ReuseIdentifier.swift
//  weather
//
//  Created by Irek Khabibullin on 19.07.2024.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        "\(Self.self)"
    }
}
