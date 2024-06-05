//
//  NetworkingRealTimeGetAPITests.swift
//
//
//  Created by Sanket Sonje  on 03/06/24.
//

import Foundation
import XCTest

@testable import NetworkingPackage

class NetworkingGetPopularMoviesAPITests: XCTestCase {

    // MARK: - Properties

    let networkServiceMock = NetworkServiceMock.shared
    let popularMoviesURL = NetworkingAPIConstants.baseURL.rawValue
        + NetworkingAPIConstants.popularMovies.rawValue
        + NetworkingAPIConstants.apiKey.rawValue

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()

        let data = MoviesMock.mockPopularMoviesData
        let trendingMoviesURL = try XCTUnwrap(URL(string: popularMoviesURL))

        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == trendingMoviesURL else {
                throw NetworkingError.getRequestError
            }

            let response = try XCTUnwrap(HTTPURLResponse(url: trendingMoviesURL, statusCode: 200, httpVersion: nil, headerFields: nil))
            return (response, data)
        }
    }

    // MARK: - Tests

    func testGetPopularMoviesAPI() throws {
        let expectation = XCTestExpectation(description: "Popular movies data fetching expectation.")
        networkServiceMock.get.popularMovies(completion: { (result: Result<TrendingMovies, Error>) in
            switch result {
            case .success(let movies):
                do {
                    try self.verify(data: movies)
                    expectation.fulfill()
                } catch {
                    XCTAssertFalse(false, error.localizedDescription)
                }
                break
            case .failure(_):
                XCTAssertFalse(false, "Failed to get data from server.")
            }
        })

        wait(for: [expectation], timeout: 5.0)
    }

    // MARK: Private Helpers

    func verify(data: TrendingMovies) throws {
        let movies = try XCTUnwrap(data.results)
        XCTAssertEqual(data.results?.count, 1)

        let movie = movies[0]
        XCTAssertEqual(movie.popularity, 160)
        XCTAssertEqual(movie.voteCount, 2324)
        XCTAssertEqual(movie.originalLanguage, "en")
        XCTAssertEqual(movie.title, "Bloodshot")
        XCTAssertEqual(movie.voteAverage, 7.1)
        XCTAssertEqual(movie.overview, "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.")
        XCTAssertEqual(movie.releaseDate, "2020-03-05")
    }
}
