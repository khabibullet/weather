//
//  View.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import Foundation

protocol WeatherViewModel: AnyObject {
    var weatherSelectorCells: [WeatherSelectorCellViewModel] { get }
    var weatherImageCells: [WeatherImageCellViewModel] { get }
    
    func setup(completion: @escaping () -> ())
    func fetchWeatherImageItem(at indexPath: IndexPath, completion: (() -> ())?)
    func cancelFetchingWeatherImageItem(at indexPath: IndexPath)
    func selectWeather(at indexPath: IndexPath)
}

final class WeatherViewModelImp: WeatherViewModel {
    private let weatherService: any WeatherService
    private let imagesProvider: any ImagesProvider
    
    var weatherSelectorCells: [WeatherSelectorCellViewModel] = []
    var weatherImageCells: [WeatherImageCellViewModel] = []
    
    private var selectedWeatherIndexPath: IndexPath?
    
    init(dependency: any DependencyContainer) {
        self.weatherService = dependency.weatherService
        self.imagesProvider = dependency.imagesProvider
    }
    
    // MARK: Public methods
    
    func setup(completion: @escaping () -> ()) {
        fetchWeatherInfo(completion: completion)
    }
    
    func fetchWeatherImageItem(at indexPath: IndexPath, completion: (() -> ())?) {
        guard let url = weatherImageCells[indexPath.item].imageUrl else { return }
        imagesProvider.loadImage(url: url) { [weak self] image in
            self?.weatherImageCells[indexPath.item].image = image
            completion?()
        }
    }
    
    func cancelFetchingWeatherImageItem(at indexPath: IndexPath) {
        guard let url = weatherImageCells[indexPath.item].imageUrl else { return }
        imagesProvider.cancelLoadingImage(url: url)
    }
    
    func selectWeather(at indexPath: IndexPath) {
        let indexPathToDeselect = selectedWeatherIndexPath
        selectedWeatherIndexPath = indexPath
        
        if let deselectedItemId = indexPathToDeselect?.item {
            weatherSelectorCells[deselectedItemId].isSelected = false
        }
        weatherSelectorCells[indexPath.item].isSelected = true
    }
    
    // MARK: Private methods
    
    private func fetchWeatherInfo(completion: @escaping () -> ()) {
        weatherService.getWeatherKinds { [weak self] weatherKinds in
            guard let self else { return }
            
            self.weatherSelectorCells = weatherKinds.map { weatherKind in
                WeatherSelectorCellViewModel(title: weatherKind.title, isSelected: false)
            }
            self.weatherImageCells = weatherKinds.map { weatherKind in
                WeatherImageCellViewModel(image: nil, imageUrl: URL(string: weatherKind.imageUrl), onReuse: { [weak self] in
                    guard let self, let url = URL(string: weatherKind.imageUrl) else { return }
                    self.imagesProvider.cancelLoadingImage(url: url)
                })
            }
            completion()
        }
    }
}
