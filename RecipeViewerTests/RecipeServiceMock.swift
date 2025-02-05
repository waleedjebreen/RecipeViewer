//
//  Untitled.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import XCTest
@testable import RecipeViewer

class RecipeServiceMock: RecipeServiceProtocol {
    var shouldReturnError = false

    func fetchRecipes(request: RecipeAPI) async throws -> RecipeViewer.RecipeResponse? {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }

        let recipes = [
            Recipe.init(
                id: 0,
                name: "Mocked Pizza Recipe",
                ingredients: ["dough, sauce, cheese"],
                instructions: ["put sauce on top", "put cheese on top", "put dough in oven"],
                prepTimeMinutes: 10,
                cookTimeMinutes: 15,
                servings: nil,
                difficulty: "Easy",
                cuisine: nil,
                caloriesPerServing: nil,
                tags: ["Italian", "Tasty"],
                userId: nil,
                image: "https://cdn.dummyjson.com/recipe-images/1.webp",
                rating: 4.5,
                reviewCount: nil,
                mealType: nil
            ),
            Recipe.init(
                id: 1,
                name: "Mocked Pasta Recipe",
                ingredients: ["pasta, onions"],
                instructions: ["put sauce on top", "put cheese on top", "put dough in oven"],
                prepTimeMinutes: 10,
                cookTimeMinutes: 15,
                servings: nil,
                difficulty: "Easy",
                cuisine: nil,
                caloriesPerServing: nil,
                tags: ["Italian", "Tasty"],
                userId: nil,
                image: "https://cdn.dummyjson.com/recipe-images/1.webp",
                rating: 4.5,
                reviewCount: nil,
                mealType: nil
            )
        ]
        
        return RecipeViewer.RecipeResponse.init(recipes: recipes, total: 2, skip: 0, limit: 10)
    }
}
