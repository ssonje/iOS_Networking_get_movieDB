//
//  MovieCrew.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 05/06/24.
//

import Foundation

/// Movie Crew data model class
struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}
