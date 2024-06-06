//
//  MovieCast.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 05/06/24.
//

import Foundation

/// Movie Cast data model class
struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}
