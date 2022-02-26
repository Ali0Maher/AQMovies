//
//  GenresCollectionViewCell.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    
    
    lazy var genereLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.backgroundColor = .secondarySystemBackground
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(genereLabel)
        
        NSLayoutConstraint.activate([
            genereLabel.topAnchor.constraint(equalTo: topAnchor),
            genereLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            genereLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            genereLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    func setupCell(genre: String) {
        genereLabel.text = genre
    }
    
}
