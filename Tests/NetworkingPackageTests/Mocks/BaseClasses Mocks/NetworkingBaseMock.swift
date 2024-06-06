//
//  NetworkManagerMock.swift
//
//
//  Created by Sanket Sonje  on 03/06/24.
//

import Foundation
@testable import NetworkingPackage

/// Mock for `NetworkManager` class which provides api's to fetch, delete, update and post data using mock data
/// Use `NetworkServiceMock.shared.get` to use this class in `Testing` environment only.
class NetworkManagerMock: NetworkManagerProtocol {

    // MARK: - Properties

    static let shared = NetworkManagerMock()
    var get: NetworkingPackage.NetworkingGetRequestAPI

    // MARK: - Init

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        self.get = NetworkingGetRequestAPIImpl(urlSession: urlSession)
    }
}
