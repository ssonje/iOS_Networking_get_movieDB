//
//  NetworkService.swift
//
//
//  Created by Sanket Sonje  on 31/05/24.
//

import Foundation

/// Provides network layer access to use and fetch movies data
/// NOTE: This is an shared class singleton, so init won't be available.
/// Example:
/// * Fetch Trending Movies
/// ```
/// NetworkService.current.get.trendingMovies
/// ```
public class NetworkService: NetworkServiceProtocol {

    // MARK: - Properties

    public static let shared: NetworkService = NetworkService()
    public let get: NetworkingGetRequestAPI

    // MARK: - Init

    private init() {
        get = NetworkingGetRequestAPIImpl(urlSession: NetworkingSession.session)
    }
}
