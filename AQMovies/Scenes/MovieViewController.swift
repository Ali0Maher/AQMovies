//
//  MovieViewController.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    private struct Constants {
        static let spacing: CGFloat = 10
        static let imageHeight: CGFloat = 300
        static let buttonSize: CGFloat = 20
        static let containerSpacing: CGFloat = 30
        static let collectionHeight: CGFloat = 50
    }
    
    // MARK: - Setuping Variables

    var collectionView: UICollectionView! = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon_remove_image"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    lazy var movieImageView: AQUIImage = {
        let imageView = AQUIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true

        return imageView
    }()
    
    lazy var movieTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    lazy var ratingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rating_star_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var ratingLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 15
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .justified
        return label
    }()
    
    
    lazy var realaseDateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)

        return label
    }()
    
    var movie: Movie?
    var genres: [MoviesGenre]?

    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
        self.genres = movie.genres
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        guard let movie = movie else {
            return
        }

        setupData(movie: movie)
    }
    
    // MARK: - Setuping Layout

    private func setupUI() {
        setupCollectionView()
        view.addSubview(backgroundView)
        view.addSubview(containerView)
        containerView.addSubview(movieImageView)
        containerView.addSubview(collectionView)
        containerView.addSubview(closeButton)
        containerView.addSubview(movieTitle)
        containerView.addSubview(ratingIcon)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(realaseDateLabel)
        containerView.addSubview(overviewLabel)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.containerSpacing),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.containerSpacing),
            containerView.bottomAnchor.constraint(equalTo: overviewLabel.safeAreaLayoutGuide.bottomAnchor, constant: Constants.containerSpacing * 2),
            
            closeButton.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: Constants.spacing),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.spacing),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            closeButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            
            movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            movieTitle.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: Constants.spacing),
            movieTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.spacing),
            movieTitle.trailingAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            ratingIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.spacing),
            ratingIcon.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: Constants.spacing),
            ratingIcon.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            ratingIcon.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingIcon.leadingAnchor, constant: -Constants.spacing/2),
            
            collectionView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: Constants.spacing/2),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.spacing),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.spacing),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionHeight),
            
            realaseDateLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.spacing),
            realaseDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.spacing),
            
            overviewLabel.topAnchor.constraint(equalTo: realaseDateLabel.bottomAnchor, constant: Constants.spacing),
            overviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.spacing),
            overviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.spacing),
            
            
        ])
        
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown.direction = .down
        view.addGestureRecognizer(swipeGestureRecognizerDown)

    }
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GenresCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Setuping Movie Data
    func setupData(movie: Movie) {
        movieImageView.loadImageWithUrl(movie.backdropPath)
        ratingLabel.text = String(movie.voteAverage)
        movieTitle.text = movie.title
        realaseDateLabel.text = "Realse Date:" + " " + movie.releaseDate
        overviewLabel.text = movie.overview
    }
    
    // MARK: - Actions
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)

    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        var frame = containerView.frame
        frame.origin.y += 50
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            self.containerView.frame = frame
        } completion: { _ in
            self.dismissView()
        }

    }
}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(GenresCollectionViewCell.self, for: indexPath)
        
        cell.setupCell(genre: genres?.get(at: indexPath.row)?.title ?? "")
        return cell
    }
    
}
extension MovieViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120 , height: 30)
        
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
    

}
