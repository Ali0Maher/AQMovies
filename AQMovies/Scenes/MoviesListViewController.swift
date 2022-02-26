//
//  MoviesListViewController.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import UIKit

class MoviesListViewController: UIViewController {
    var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    lazy var viewModel: MoviesListViewModel = {
        return DefaultMoviesListViewModel(with: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasicView()
        setupUI()
        viewModel.getMoviesList()
        
    }

    
    // MARK: - Setuping Layout
    
    func setupBasicView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Popular Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        viewModel.setupCollectionView(collectionView: &collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    
    
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(MoviesCollectionViewCell.self, for: indexPath)
        
        if let item = viewModel.item(row: indexPath.row) {
            cell.setupCell(movie: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = viewModel.item(row: indexPath.row) {
            let vc = MovieViewController(movie: movie)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
}
extension MoviesListViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 5, height: 270)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !viewModel.isLoadingList){
            self.viewModel.getMoviesList()
        }
    }
}

extension MoviesListViewController: MoviesListViewModelDelegate {
    func reloadDate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    func exitWithError(error: String) {
        print(error)
    }
    
    
}
