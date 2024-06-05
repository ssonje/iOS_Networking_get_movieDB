//
//  NetworkingGetTrendingMoviesAPITests.swift
//
//
//  Created by Sanket Sonje  on 03/06/24.
//

import Foundation
import XCTest

@testable import NetworkingPackage

class NetworkingGetTrendingMoviesAPITests: XCTestCase {

    // MARK: - Properties

    let networkServiceMock = NetworkServiceMock.shared
    let trendingMoviesURL = NetworkingAPIConstants.baseURL.rawValue
        + NetworkingAPIConstants.trendingMovies.rawValue
        + NetworkingAPIConstants.apiKey.rawValue

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()

        let data = MoviesMock.mockTrendingMoviesData
        let trendingMoviesURL = try XCTUnwrap(URL(string: trendingMoviesURL))

        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == trendingMoviesURL else {
                throw NetworkingError.getRequestError
            }

            let response = try XCTUnwrap(HTTPURLResponse(url: trendingMoviesURL, statusCode: 200, httpVersion: nil, headerFields: nil))
            return (response, data)
        }
    }

    // MARK: - Tests

    func testGetTrendingMoviesAPI() throws {
        let expectation = XCTestExpectation(description: "Trending movies data fetching expectation.")
        networkServiceMock.get.trendingMovies(completion: { (result: Result<TrendingMovies, Error>) in
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
        XCTAssertEqual(movie.popularity, 6097.733)
        XCTAssertEqual(movie.voteCount, 781)
        XCTAssertEqual(movie.originalLanguage, "en")
        XCTAssertEqual(movie.title, "Kingdom of the Planet of the Apes")
        XCTAssertEqual(movie.voteAverage, 6.9)
        XCTAssertEqual(movie.overview, "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.")
        XCTAssertEqual(movie.releaseDate, "2024-05-08")
    }
}
