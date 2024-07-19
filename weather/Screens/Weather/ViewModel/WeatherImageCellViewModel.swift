//
//  WeatherImageCellViewModel.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import UIKit

struct WeatherImageCellViewModel {
    var image: UIImage?
    var imageUrl: URL?
    
    var onReuse: () -> ()
}
