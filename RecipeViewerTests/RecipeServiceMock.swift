//
//  Untitled.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import XCTest
@testable import RecipeViewer

class MockRecipeService: RecipeServiceProtocol {
    var mockResponse: RecipeResponse?
    var mockError: Error?
    
    func fetchRecipes(request: NetworkModule) async throws -> RecipeResponse? {
        if let error = mockError {
            throw error
        }
        return mockResponse
    }
    
    func generateMockResponse() -> RecipeResponse? {
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
        
        return RecipeResponse.init(recipes: recipes, total: 2, skip: 0, limit: 10)
    }
}
