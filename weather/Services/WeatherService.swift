//
//  WeatherService.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import Foundation

protocol WeatherService: AnyObject {
    func getWeatherKinds(completion: @escaping ([WeatherKind]) -> ())
}

final class WeatherServiceImp: WeatherService {
    func getWeatherKinds(completion: @escaping ([WeatherKind]) -> ()) {
        completion([
            WeatherKind(
                title: "Sunny",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/sunny.jpg"
            ),
            WeatherKind(
                title: "Cloudy",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/cloudy.jpg"
            ),
            WeatherKind(
                title: "Partly cloudy",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/partly-cloudy.jpg"
            ),
            WeatherKind(
                title: "Rain",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/rain.jpg"
            ),
            WeatherKind(
                title: "Pouring rain",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/pouring-rain.jpg"
            ),
            WeatherKind(
                title: "Thunderstorm",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/thunderstorm.jpg"
            ),
            WeatherKind(
                title: "Snowfall",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/snowfall.jpg"
            ),
            WeatherKind(
                title: "Wind",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/wind.jpg"
            ),
            WeatherKind(
                title: "Hot",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/hot.jpg"
            ),
            WeatherKind(
                title: "Sunset",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/sunset.jpg"
            ),
            WeatherKind(
                title: "Starry night",
                imageUrl: "https://raw.githubusercontent.com/khabibullet/weather/master/assets/starry-night.jpg"
            ),
        ])
    }
}
