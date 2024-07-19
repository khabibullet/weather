//
//  ViewController.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import UIKit

protocol WeatherViewControllable: ViewControllable {
    
}

class WeatherViewController: UIViewController, WeatherViewControllable {
    // MARK: Private properties
    private let viewModel: any WeatherViewModel
    
    // MARK: Subviews
    
    private let imagesCollectionView = UICollectionView()
    private let selectorCollectionView = UICollectionView()
    
    // MARK: Lifecycle
    
    init(viewModel: any WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = imagesCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        setupSubviews()
        setConstraints()
        
        viewModel.setup { [weak self] in
            self?.selectorCollectionView.reloadData()
            self?.imagesCollectionView.reloadData()
        }
    }
    
    // MARK: Private methods

    private func setupSubviews() {
        imagesCollectionView.backgroundColor = .blue
        
        selectorCollectionView.register(
            WeatherSelectorCell.self,
            forCellWithReuseIdentifier: WeatherSelectorCell.reuseIdentifier
        )
    }
    
    private func setConstraints() {
        
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === selectorCollectionView {
            return viewModel.weatherSelectorCells.count
        } else if collectionView === imagesCollectionView {
            return viewModel.weatherImageCells.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegate {
    
}

extension WeatherViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard collectionView === imagesCollectionView else { return }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
