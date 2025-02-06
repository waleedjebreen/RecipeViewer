//
//  RecipeService.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(request: NetworkModule) async throws -> RecipeResponse?
}

class RecipeService: RecipeServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchRecipes(request: NetworkModule) async throws -> RecipeResponse? {
        return try await networkManager.request(request)
    }
}
