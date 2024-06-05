//
//  NetworkingAPIConstants.swift
//  
//
//  Created by Sanket Sonje  on 31/05/24.
//

import Foundation

/// Enum which provides URL's which gives data from server
enum NetworkingAPIConstants: String {

    case apiKey = "?api_key=909594533c98883408adef5d56143539"
    case baseURL = "https://api.themoviedb.org/3"
    case trendingMovies = "/trending/all/day"
    case popularMovies = "/movie/popular"

}
