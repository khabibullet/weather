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
        imagesCollectionView.register(
            WeatherImageCell.self,
            forCellWithReuseIdentifier: WeatherImageCell.reuseIdentifier
        )
        imagesCollectionView.backgroundColor = .gray
        imagesCollectionView.isPagingEnabled = true
        imagesCollectionView.dataSource = self
        imagesCollectionView.prefetchDataSource = self
        imagesCollectionView.delegate = self
        
        imagesCollectionView.addSubview(selectorCollectionView)
        selectorCollectionView.register(
            WeatherSelectorCell.self,
            forCellWithReuseIdentifier: WeatherSelectorCell.reuseIdentifier
        )
        selectorCollectionView.backgroundColor = .yellow
        selectorCollectionView.dataSource = self
        selectorCollectionView.prefetchDataSource = self
        selectorCollectionView.delegate = self
        selectorCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            selectorCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectorCollectionView.trailingAnchor.constraint(equalTo: view.leadingAnchor),
            selectorCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
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
        if collectionView === selectorCollectionView {
            guard let cell = selectorCollectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherSelectorCell.reuseIdentifier, for: indexPath
            ) as? WeatherSelectorCell else { return UICollectionViewCell() }
            let cellViewModel = viewModel.weatherSelectorCells[indexPath.item]
            cell.configureCell(with: cellViewModel)
            return cell
        } else if collectionView === imagesCollectionView {
            guard let cell = imagesCollectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherImageCell.reuseIdentifier, for: indexPath
            ) as? WeatherImageCell else { return UICollectionViewCell() }
            let cellViewModel = viewModel.weatherImageCells[indexPath.item]
            cell.configureCell(with: cellViewModel)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegate {
    
}

extension WeatherViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard collectionView === imagesCollectionView else { return }
        indexPaths.forEach { indexPath in
            viewModel.prefetchWeatherImageItem(at: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        guard collectionView === imagesCollectionView else { return }
        indexPaths.forEach { indexPath in
            viewModel.cancelPrefetchingWeatherImageItem(at: indexPath)
        }
    }
}
