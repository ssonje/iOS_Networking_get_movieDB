//
//  Movie.swift
//
//
//  Created by Sanket Sonje  on 31/05/24.
//

import Foundation

/// Movie data model class
struct Movie: Decodable, Hashable {

    // MARK: - API Data

    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let credits: MovieCredit?
    let genres: [MovieGenre]?
    let id: Int?
    let mediaType: String?
    let originalLanguage: String?
    let overview: String?
    let popularity: Float?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let revenue: Int?
    let status: String?
    let voteAverage: Float?
    let voteCount: Int?
    let title: String?

    private enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case budget = "budget"
        case credits = "credits"
        case genres = "genres"
        case id = "id"
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime = "runtime"
        case revenue = "revenue"
        case status = "status"
        case title = "original_title"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    // MARK: - Computed Properties

    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }

    var cast: [MovieCast]? {
        credits?.cast
    }

    var crew: [MovieCrew]? {
        credits?.crew
    }

    // MARK: - Decodable

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
