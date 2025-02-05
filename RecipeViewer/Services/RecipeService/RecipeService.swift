//
//  RecipeService.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(request: RecipeAPI) async throws -> RecipeResponse?
}

class RecipeService: RecipeServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchRecipes(request: RecipeAPI) async throws -> RecipeResponse? {
        return try await networkManager.request(request)
    }
}
