//
//  MoviesGenre.swift
//  AQMovies
//
//  Created by Ali on 2/26/22.
//

import Foundation

//MARK: - Genres As per TMDB
enum MoviesGenre: Int, Codable {
    case Action           = 28
    case Adventure        = 12
    case Animation        = 16
    case Comedy           = 35
    case Crime            = 80
    case Documentary      = 99
    case Drama            = 18
    case Family           = 10751
    case Fantasy          = 14
    case History          = 36
    case Horror           = 27
    case Music            = 10402
    case Mystery          = 9648
    case Romance          = 10749
    case ScienceFiction   = 878
    case TVMovie          = 10770
    case Thriller         = 53
    case War              = 10752
    case Western          = 37
    
    var title: String {
        switch self {
        case .Action:
            return "Action"
        case .Adventure:
            return "Adventure"
        case .Animation:
            return "Animation"
        case .Comedy:
            return "Comedy"
        case .Crime:
            return "Crime"
        case .Documentary:
            return "Documentary"
        case .Drama:
            return "Drama"
        case .Family:
            return "Family"
        case .Fantasy:
            return "Fantasy"
        case .History:
            return "History"
        case .Horror:
            return "Horror"
        case .Music:
            return "Music"
        case .Mystery:
            return "Mystery"
        case .Romance:
            return "Romance"
        case .ScienceFiction:
            return "ScienceFiction"
        case .TVMovie:
            return "TVMovie"
        case .Thriller:
            return "Thriller"
        case .War:
            return "War"
        case .Western:
            return "Western"
        }
    }
}
