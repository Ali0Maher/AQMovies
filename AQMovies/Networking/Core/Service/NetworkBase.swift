//
//  NetworkBase.swift
//  Delivery Boy
//
//  Created by Ali on 12/5/21.
//

import UIKit

typealias Parameters = [String: Any]


class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL = "https://api.themoviedb.org/3/"
    let imagesLink = "https://image.tmdb.org/t/p/w500/"
    func baseNetwork<T: Codable>(for params : [String:Any], endPoint: String, type: T.Type, method: HttpMethod = .get, completed : @escaping (Result<T , NetworkErrors>) -> Void){
        var endpoint = baseURL + endPoint
        
        if method == .get {
            endpoint = endpoint +  "?" + (params.encodeForUrl() ?? "")
        }
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if method != .get {
            let dataBody = params.percentEncoded()
            request.httpBody = dataBody
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let _ = error  {
                completed(.failure(.invalidURL))
                
                
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidRespons))
                
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    print(error)
                }
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(type, from: data)
                completed(.success(data))
            } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError)")
                completed(.failure(.invalidData))
            }
            
            
        }
        
        task.resume()
        
    }
    
    
}
