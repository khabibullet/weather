//
//  ImagesProvider.swift
//  weather
//
//  Created by Irek Khabibullin on 18.07.2024.
//

import UIKit

protocol ImagesProvider: AnyObject {
    func loadImage(url: URL, completion: @escaping (UIImage?) -> ())
    func cancelLoadingImage(url: URL)
}

final class ImagesProviderImp: ImagesProvider {
    private let imagesCache = NSCache<NSURL, UIImage>()
    private var dataTasks = Dictionary<URL, URLSessionDataTask>()
    private var loadingResponses = Dictionary<URL, [(UIImage?) -> ()]>()
    
    private let lock = DispatchQueue(label: "imageProviderLock", qos: .background)
    
    func loadImage(url: URL, completion: @escaping (UIImage?) -> ()) {
        if let cachedImage = imagesCache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        lock.async {
            if self.loadingResponses[url] != nil {
                self.loadingResponses[url]?.append(completion)
                return
            } else {
                self.loadingResponses[url] = [completion]
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            var image: UIImage? = nil
            if
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                error == nil,
                let responseData = data {
                if let decodedImage = UIImage(data: responseData) {
                    self?.imagesCache.setObject(decodedImage, forKey: url as NSURL, cost: responseData.count)
                    image = decodedImage
                }
            }
            self?.lock.async {
                self?.loadingResponses[url]?.forEach { block in
                    DispatchQueue.main.async {
                        block(image)
                    }
                }
                self?.loadingResponses.removeValue(forKey: url)
            }
        }
        dataTask.resume()
        lock.async {
            self.dataTasks[url] = dataTask
        }
    }
    
    func cancelLoadingImage(url: URL) {
        lock.async {
            self.loadingResponses.removeValue(forKey: url)
            let dataTask = self.dataTasks.removeValue(forKey: url)
            dataTask?.cancel()
        }
    }
}
