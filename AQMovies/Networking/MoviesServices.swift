//
//  MoviesServices.swift
//  PortFlash
//
//  Created by Ali on 2/6/22.
//

import Foundation

protocol MoviesServicesDelegate: AnyObject {
    func didGetMoviesList(result : (Result<MovieList , NetworkErrors>))

}


final class MoviesServices {
    var service = NetworkManager.shared
    weak var delegate: MoviesServicesDelegate?
    
//    init(with delegate: MoviesServicesDelegate) {
//        self.delegate = delegate
//    }
    
    
    func getMoviesList(page: Int) {
        let endPoint = "movie/popular/"
        service.baseNetwork(for: ["page":page, "api_key": Helper.apiKey], endPoint: endPoint, type: MovieList.self) { [weak self] result in
            switch result {
            case .success(let result) :
                self?.delegate?.didGetMoviesList(result: .success(result))
            case .failure(let error) :
                self?.delegate?.didGetMoviesList(result: .failure(error))
            }
        }
    }
    
}
