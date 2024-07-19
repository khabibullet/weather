//
//  WeatherSelectorCell.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import UIKit

class WeatherSelectorCell: UICollectionViewCell {
    // MARK: Subviews
    
    private let selectorLabel = UILabel()
    
    // MARK: Public methods
    
    func configureCell(with viewModel: WeatherSelectorCellViewModel) {
        selectorLabel.text = viewModel.title
        
        if viewModel.isSelected {
            setSelected()
        } else {
            setUnselected()
        }
    }
    
    // MARK: Private methods
    
    private func setSelected() {
        
    }
    
    private func setUnselected() {
        
    }
}
