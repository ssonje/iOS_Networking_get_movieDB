//
//  Movie.swift
//
//
//  Created by Sanket Sonje  on 31/05/24.
//

import Foundation

/// Movies data model class
public struct TrendingMovies: Decodable {
    let page: Int?
    let results: [Movie]?

    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
    }
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let backdropPath: String?
    let posterPath: String?
    let mediaType: String?
    let adult: Bool?
    let originalLanguage: String?
    let popularity: Float?
    let releaseDate: String?
    let voteAverage: Float?
    let voteCount: Int?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "original_title"
        case overview = "overview"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult = "adult"
        case originalLanguage = "original_language"
        case popularity = "popularity"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
