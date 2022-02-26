//
//  MoviesListViewModel.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import UIKit



protocol MoviesListViewModel {
    var numberOfCells: Int { get }
    var numberOfSections: Int { get }
    var isLoadingList: Bool { get set }
    func item(row: Int) -> Movie?
    func getMoviesList()
    func setupCollectionView(collectionView: inout UICollectionView)
}

protocol MoviesListViewModelDelegate: AnyObject {
    func reloadDate()
    func exitWithError(error: String)
}

final class DefaultMoviesListViewModel: MoviesListViewModel {
    
    private var movies: [Movie] = []
    
    private var moviesServices: MoviesServices =  {
        return MoviesServices()
    }()
    
    private var currentPage: Int = 0
    private var noMore = false
    var isLoadingList = false
    
    weak var delegate: MoviesListViewModelDelegate?
    
    init(with delegate: MoviesListViewModelDelegate) {
        self.delegate = delegate
        moviesServices.delegate = self
    }
    
    var numberOfCells: Int {
        return movies.count
    }
    
    var numberOfSections: Int {
        1
    }
    
    func item(row: Int) -> Movie? {
        movies.get(at: row)
    }
    
    func getMoviesList() {
        guard !noMore else { return }
        isLoadingList = true
        currentPage += 1
        moviesServices.getMoviesList(page: currentPage)
    }
    
    
    func setupCollectionView(collectionView: inout UICollectionView) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MoviesCollectionViewCell.self)
    }
    
}


extension DefaultMoviesListViewModel: MoviesServicesDelegate {
    func didGetMoviesList(result: (Result<MovieList, NetworkErrors>)) {
        switch result {
        case .success(let result):

            if result.movies.isEmpty {
                noMore = true
            }
            self.movies = result.movies.isEmpty ? self.movies : self.movies + result.movies
            delegate?.reloadDate()
            
        case .failure(let error):
            delegate?.exitWithError(error: error.rawValue)
        }
        isLoadingList = false
        
    }
    
    
}
