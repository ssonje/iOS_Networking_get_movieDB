//
//  File.swift
//  
//
//  Created by Sanket Sonje  on 06/06/24.
//

import Foundation
import XCTest

@testable import NetworkingPackage

class NetworkingMovieInfoTests: XCTestCase {

    func testMovieInformation() throws {
        let movieInfo = MoviesMock.mockMovieInfoData
        XCTAssertNotNil(movieInfo)
        XCTAssertEqual(movieInfo.adult, false)
        XCTAssertEqual(movieInfo.budget, 42000000)
        XCTAssertEqual(movieInfo.originalLanguage, "en")
        XCTAssertEqual(movieInfo.title, "Bloodshot")
        XCTAssertEqual(movieInfo.overview, "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.")
        XCTAssertEqual(movieInfo.popularity, 160.0)
        XCTAssertEqual(movieInfo.releaseDate, "2020-03-05")
        XCTAssertEqual(movieInfo.revenue, 24573617)
        XCTAssertEqual(movieInfo.status, "Released")
        XCTAssertEqual(movieInfo.voteAverage, 7.1)
        XCTAssertEqual(movieInfo.voteCount, 2324)

        let genres = try XCTUnwrap(movieInfo.genres)
        XCTAssertEqual(genres.count, 3)
        XCTAssertEqual(genres[0].name, "Action")
        XCTAssertEqual(genres[1].name, "Science Fiction")
        XCTAssertEqual(genres[2].name, "Drama")

        let credits = try XCTUnwrap(movieInfo.credits)
        XCTAssertNotNil(credits.crew)
        XCTAssertNotNil(credits.cast)

        let cast = try XCTUnwrap(movieInfo.cast)
        XCTAssertEqual(cast[0].id, 12835)
        XCTAssertEqual(cast[0].character, "Ray Garrison / Bloodshot")
        XCTAssertEqual(cast[0].name, "Vin Diesel")

        let crew = try XCTUnwrap(movieInfo.crew)
        XCTAssertEqual(crew[0].id, 561)
        XCTAssertEqual(crew[0].job, "Casting")
        XCTAssertEqual(crew[0].name, "John Papsidera")
    }
}
