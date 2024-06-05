//
//  MockURLProtocol.swift
//
//
//  Created by Sanket Sonje  on 03/06/24.
//

import Foundation


/// Protocol to mock the URLRequest and pass mock data instead of fetching data from real time server.
class MockURLProtocol: URLProtocol {

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

    // Check if protocol can handle the given request or not
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // Teturn the canonical version of the request
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    // Mock the data for the particular request and send it to the `URLProtocolClient`.
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            // If request handler is not mentioned, return the falal error.
            fatalError("Handler is unavailable.")
        }

        do {
            // Get response and data from the handler for the particular request
            let (response, data) = try handler(request)

            // Send received response to the client
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {
                // Send mock data to the client
                client?.urlProtocol(self, didLoad: data)
            }

            // Notify client that request has been finished.
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            // Notify client that there is an error while executing the request.
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
        // NO-OP
    }
}
