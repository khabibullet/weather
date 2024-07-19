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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        selectorLabel.numberOfLines = 0
        selectorLabel.textAlignment = .natural
        selectorLabel.textColor = .black
        
        contentView.addSubview(selectorLabel)
        selectorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            selectorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectorLabel.widthAnchor.constraint(equalToConstant: 80),
            
            contentView.heightAnchor.constraint(equalToConstant: 60),
            contentView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
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
