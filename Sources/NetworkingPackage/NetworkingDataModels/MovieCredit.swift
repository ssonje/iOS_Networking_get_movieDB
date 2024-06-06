//
//  MovieCredit.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 05/06/24.
//

import Foundation

/// Movie Credit data model class
struct MovieCredit: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}
