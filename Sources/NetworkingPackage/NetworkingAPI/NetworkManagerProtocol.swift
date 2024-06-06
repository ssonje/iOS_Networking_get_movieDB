//
//  NetworkServiceProtocol.swift
//
//
//  Created by Sanket Sonje  on 03/06/24.
//

import Foundation

/// Network base protocol which provides the get, post, put and delete api's
protocol NetworkManagerProtocol {

    /// Get api to fetch data from the server.
    /// Currently, provides api's for fetching trending and popular movies.
    var get: NetworkingGetRequestAPI { get }

}
