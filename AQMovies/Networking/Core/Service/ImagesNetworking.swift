//
//  ImagesNetworking.swift
//  Craft
//
//  Created by Ali on 9/29/21.
//

import UIKit
typealias CompletionHandler = () -> UIImage

extension NetworkManager {
    
    
    func downloadImage(from url: String, completion: @escaping (UIImage) -> Void) {
        guard let urlUsed = URL(string: baseURL + url) else { return }
        getData(from: urlUsed) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            completion(UIImage(data: data) ?? #imageLiteral(resourceName: "bannerTest"))
            
        }
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
