//
//  NetworkingGetRequestAPIImpl.swift
//  
//
//  Created by Sanket Sonje  on 31/05/24.
//

import Foundation

/// Implementation class which provides actual network request hit for fetching trending and popular movies using URLSession
class NetworkingGetRequestAPIImpl: NetworkingGetRequestAPI {

    // MARK: - Properties

    private let urlSession: URLSession

    // MARK: - Init

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    // MARK: - Trending Movings GET API Implementation

    func trendingMovies<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        let trendingMoviesURLString = getURLForTrendingMovies()
        fetchData(urlString: trendingMoviesURLString, completion: { (result: Result<T, Error>) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        })
    }

    // MARK: - Popular Movings GET API Implementation

    func popularMovies<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        let popularMoviesURLString = getURLForPopularMovies()
        fetchData(urlString: popularMoviesURLString, completion: { (result: Result<T, Error>) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        })
    }

    // MARK: - Private Helpers

    func fetchData<T>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        guard let trendingMoviesURL = URL(string: urlString) else {
            print("[NetworkingGetRequestAPIImpl] Found `postsURL` nil")
            return
        }

        // Create URL Session to fetch data
        let dataTask = urlSession.dataTask(with: trendingMoviesURL) { (data, response, error) in
            if let error {
                print("[NetworkingGetRequestAPIImpl] Unfortunately, get request failed with error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard response is HTTPURLResponse else {
                print("[NetworkingGetRequestAPIImpl] Get nil response from the server. Hence, Unable to parse the response as HTTPURLResponse")
                return
            }

            guard let data else {
                print("[NetworkingGetRequestAPIImpl] Get nil data from the server.")
                return
            }

            do {
                // Parse the data
                let jsonDecoder = JSONDecoder()
                let jsonData = try jsonDecoder.decode(T.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    print("[NetworkingGetRequestAPIImpl] Data fetched successfully.")
                }
            } catch {
                print("[NetworkingGetRequestAPIImpl] Failed to decode the data.")
                completion(.failure(error))
                return
            }
        }

        dataTask.resume()
    }

    private func getURLForTrendingMovies() -> String {
        return NetworkingAPIConstants.baseURL.rawValue
        + NetworkingAPIConstants.trendingMovies.rawValue
        + NetworkingAPIConstants.apiKey.rawValue
    }

    private func getURLForPopularMovies() -> String {
        return NetworkingAPIConstants.baseURL.rawValue
        + NetworkingAPIConstants.popularMovies.rawValue
        + NetworkingAPIConstants.apiKey.rawValue
    }
}
