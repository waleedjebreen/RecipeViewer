//
//  NetworkManager.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ module: NetworkModule) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func request<T: Decodable>(_ module: NetworkModule) async throws -> T {
        guard let request = module.buildURLRequest(baseURL: baseURL) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
