//
//  WeatherScreenBuilder.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

protocol WeatherScreenBuilder: AnyObject {
    func build(dependency: any DependencyContainer) -> any WeatherViewControllable
}

final class WeatherScreenBuilderImp: WeatherScreenBuilder {
    func build(dependency: any DependencyContainer) -> any WeatherViewControllable {
        let viewModel = WeatherViewModelImp(dependency: dependency)
        let view = WeatherViewController(viewModel: viewModel)
        return view
    }
}
