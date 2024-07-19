//
//  WeatherImageCell.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import UIKit

class WeatherImageCell: UICollectionViewCell {
    // MARK: Subviews
    
    private let imageView = UIImageView()
    
    private var onReuse: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    func configureCell(with viewModel: WeatherImageCellViewModel) {
        onReuse = viewModel.onReuse
        imageView.image = viewModel.image
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        onReuse?()
    }
    
}
