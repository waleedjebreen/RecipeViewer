//
//  RecipeService.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]?
}

class RecipeService: RecipeServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchRecipes() async throws -> [Recipe]? {
        let request = RecipeAPI(method: .get)
        return try await networkManager.request(request)
    }
}
