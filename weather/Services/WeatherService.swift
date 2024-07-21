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
        guard let url = URL(string: "https://raw.githubusercontent.com/khabibullet/public/main/assets/weather/weather-data.json") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            if let data, let weatherKinds = try? JSONDecoder().decode([WeatherKind].self, from: data) {
                DispatchQueue.main.async {
                    completion(weatherKinds)
                }
            } else {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}
