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
    
    private var imagesCollectionView: UICollectionView!
    private var selectorCollectionView: UICollectionView!
    
    private let blurredHeader = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    // MARK: Lifecycle
    
    init(viewModel: any WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setConstraints()
        
        viewModel.setup { [weak self] in
            guard let self else { return }
            
            self.selectorCollectionView.reloadData()
            self.imagesCollectionView.reloadData()
            
            [0, 1].map { IndexPath(item: $0, section: 0) }.forEach { indexPath in
                self.viewModel.fetchWeatherImageItem(at: indexPath) {
                    self.imagesCollectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
    
    // MARK: Private methods

    private func setupSubviews() {
        
        let imagesCollectionFlowLayout = UICollectionViewFlowLayout()
        imagesCollectionFlowLayout.scrollDirection = .horizontal
        imagesCollectionFlowLayout.itemSize = UIScreen.main.bounds.size
        imagesCollectionFlowLayout.minimumLineSpacing = .zero
        
        imagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imagesCollectionFlowLayout)
        imagesCollectionView.register(
            WeatherImageCell.self,
            forCellWithReuseIdentifier: WeatherImageCell.reuseIdentifier
        )
        imagesCollectionView.backgroundColor = .white
        imagesCollectionView.isPagingEnabled = true
        imagesCollectionView.dataSource = self
        imagesCollectionView.prefetchDataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imagesCollectionView.showsHorizontalScrollIndicator = false
        imagesCollectionView.isScrollEnabled = false
        view.addSubview(imagesCollectionView)
        
        
        blurredHeader.translatesAutoresizingMaskIntoConstraints = false
        blurredHeader.alpha = 1.0
        blurredHeader.layer.cornerRadius = 20
        blurredHeader.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        blurredHeader.clipsToBounds = true
        view.addSubview(blurredHeader)
        
        let selectorCollectionFlowLayout = UICollectionViewFlowLayout()
        selectorCollectionFlowLayout.scrollDirection = .horizontal
        selectorCollectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        selectorCollectionFlowLayout.minimumLineSpacing = 20
        
        selectorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: selectorCollectionFlowLayout)
        selectorCollectionView.register(
            WeatherSelectorCell.self,
            forCellWithReuseIdentifier: WeatherSelectorCell.reuseIdentifier
        )
        selectorCollectionView.dataSource = self
        selectorCollectionView.prefetchDataSource = self
        selectorCollectionView.delegate = self
        selectorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        selectorCollectionView.backgroundColor = .clear
        selectorCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        selectorCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(selectorCollectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blurredHeader.topAnchor.constraint(equalTo: view.topAnchor),
            blurredHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurredHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurredHeader.bottomAnchor.constraint(equalTo: selectorCollectionView.bottomAnchor, constant: 20),
            
            selectorCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectorCollectionView.heightAnchor.constraint(equalToConstant: 50)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView === selectorCollectionView else { return }
        
        viewModel.selectWeather(at: indexPath)
        selectorCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        imagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

extension WeatherViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard collectionView === imagesCollectionView else { return }
        indexPaths.forEach { indexPath in
            viewModel.fetchWeatherImageItem(at: indexPath) { [weak self] in
                self?.imagesCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        guard collectionView === imagesCollectionView else { return }
        indexPaths.forEach { indexPath in
            viewModel.cancelFetchingWeatherImageItem(at: indexPath)
        }
    }
}
