//
//  NetworkingGetRequestAPI.swift
//
//
//  Created by Sanket Sonje  on 31/05/24.
//

import Foundation

/// Get request protocol which provides api's to fetch trending and popular movies
public protocol NetworkingGetRequestAPI {

    /// Fetches trending movies from the API and provides the Result `T` and error `Error`.
    func trendingMovies<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Decodable

    /// Fetches popular movies from the API and provides the Result `T` and error `Error`.
    func popularMovies<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Decodable

}
