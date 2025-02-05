//
//  NetworkManager.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(url: URL) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
