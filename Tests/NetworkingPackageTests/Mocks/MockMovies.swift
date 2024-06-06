//
//  MoviesMock.swift
//
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation

@testable import NetworkingPackage

// MARK: - MoviesMock

/// Mock class which provides mock data for trending and popular movies
public class MoviesMock {

    static var mockMovies: [Movie] {
        let response: TrendingMovies? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return (response?.results)!
    }

    static var mockMovie: Movie {
        mockMovies[0]
    }

    static var mockTrendingMoviesData: Data? {
        let data = try? Bundle.module.loadData(from: "trending_movie")
        return data
    }

    static var mockPopularMoviesData: Data? {
        let data = try? Bundle.module.loadData(from: "popular_movie")
        return data
    }

    static var mockMovieInfoData: Movie {
        let movie: Movie? = try? Bundle.module.loadAndDecodeJSON(filename: "movie_info")
        return movie!
    }
}

// MARK: - Extension Bundle

extension Bundle {

    func loadAndDecodeJSON<T: Decodable>(filename: String) throws -> T? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let jsonData = try jsonDecoder.decode(T.self, from: data)
        return jsonData
    }

    func loadData(from file: String) throws -> Data? {
        guard let url = self.url(forResource: file, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        return data
    }
}
