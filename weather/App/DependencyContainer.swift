//
//  DependencyContainer.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import Foundation

protocol DependencyContainer: AnyObject {
    var weatherService: any WeatherService { get }
    var imagesProvider: any ImagesProvider { get }
}

final class DependencyContainerImp: DependencyContainer {
    let weatherService: any WeatherService
    let imagesProvider: any ImagesProvider
    
    init(weatherService: any WeatherService, imagesProvider: any ImagesProvider) {
        self.weatherService = weatherService
        self.imagesProvider = imagesProvider
    }
}
