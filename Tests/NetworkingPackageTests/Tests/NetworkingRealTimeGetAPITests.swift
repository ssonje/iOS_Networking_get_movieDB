//
//  NetworkingGetPopularMoviesAPITests.swift
//
//
//  Created by Sanket Sonje  on 04/06/24.
//

import Foundation
import XCTest

@testable import NetworkingPackage

class NetworkingRealTimeGetAPITests: XCTestCase {

    // MARK: - Tests

    func testNetworkFetchTrendingMovies() {
        let expectation = XCTestExpectation(description: "Fetch trending movies data from real time server expectation.")
        NetworkManager.shared.get.trendingMovies(completion: { (result: Result<TrendingMovies, Error>) in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                expectation.fulfill()
                break
            case .failure(_):
                XCTAssertTrue(false)
            }
        })

        wait(for: [expectation], timeout: 5.0)
    }

    func testNetworkFetchPopularMovies() {
        let expectation = XCTestExpectation(description: "Fetch popular movies data from real time server expectation.")
        NetworkManager.shared.get.popularMovies(completion: { (result: Result<TrendingMovies, Error>) in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                expectation.fulfill()
                break
            case .failure(_):
                XCTAssertTrue(false)
            }
        })

        wait(for: [expectation], timeout: 5.0)
    }
}
