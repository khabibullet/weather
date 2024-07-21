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
    
    private let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .gray
        container.alpha = 0.2
        container.layer.cornerRadius = 15
        contentView.addSubview(container)
        
        selectorLabel.translatesAutoresizingMaskIntoConstraints = false
        selectorLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        selectorLabel.textAlignment = .natural
        selectorLabel.textColor = .black
        contentView.addSubview(selectorLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            selectorLabel.topAnchor.constraint(equalTo: container.topAnchor),
            selectorLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            selectorLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            selectorLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            selectorLabel.heightAnchor.constraint(equalToConstant: 50)
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
        self.isSelected = true
    }
    
    private func setUnselected() {
        self.isSelected = false
    }
}
