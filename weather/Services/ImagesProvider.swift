//
//  ImagesProvider.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import UIKit

protocol ImagesProvider: AnyObject {
    func loadImage(url: URL, completion: @escaping (UIImage?) -> ())
}

final class ImagesProviderImp: ImagesProvider {
    private let imagesCache = NSCache<NSURL, UIImage>()
    
    func loadImage(url: URL, completion: @escaping (UIImage?) -> ()) {
        
    }
}
