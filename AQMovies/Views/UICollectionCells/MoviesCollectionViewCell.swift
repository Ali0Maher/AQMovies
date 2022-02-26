//
//  MoviesCollectionViewCell.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    lazy var movieImageView: AQUIImage = {
        let imageView = AQUIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var ratingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rating_star_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var HeaderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    var gradiantLayer = CAGradientLayer()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(movieImageView)
        addSubview(ratingIcon)
        addSubview(HeaderLabel)

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            ratingIcon.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -10),
            ratingIcon.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -10),
            ratingIcon.heightAnchor.constraint(equalToConstant: 15),
            ratingIcon.widthAnchor.constraint(equalToConstant: 15),
            
            HeaderLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor, constant: 0),
            HeaderLabel.trailingAnchor.constraint(equalTo: ratingIcon.leadingAnchor, constant: -5)
        ])
        movieImageView.gradient(gradientLayer: gradiantLayer ,colors: [UIColor.clear.cgColor, UIColor.black.cgColor], startPoint: CGPoint.init(x: 0.2, y: 0.0), endPoint: CGPoint.init(x: 0.2, y: 0.4), opacity: 0.4, location: [0,1])

    }
    
    func setupCell(movie: Movie) {
        movieImageView.loadImageWithUrl(movie.posterPath)
        HeaderLabel.text = String(movie.voteAverage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradiantLayer.frame = movieImageView.bounds
    }
}
