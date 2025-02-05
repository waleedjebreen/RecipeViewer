//
//  RecipeListViewModel.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .none
    var totalRecipesCount: Int = -1

    private let service: RecipeServiceProtocol

    init(service: RecipeServiceProtocol) {
        self.service = service
        
        Task {
            await fetchRecipes()
        }
    }

    enum SortOption {
        case alphabetical, reverseAlphabetical, none
    }

    var filteredRecipes: [Recipe] {
        var filtered = recipes.filter { recipe in
            searchText.isEmpty || recipe.name?.contains(searchText) ?? false
        }

        switch sortOption {
        case .alphabetical:
            filtered.sort { $0.getName() < $1.getName() }
        case .reverseAlphabetical:
            filtered.sort { $0.getName() > $1.getName() }
        case .none:
            break
        }

        return filtered
    }

    func fetchRecipes() async {
        
        guard self.recipes.count != totalRecipesCount else { return }
        isLoading = true
        errorMessage = nil

        do {
            let request = RecipeAPI(method: .get, queryParameters: ["limit": 10, "skip": recipes.count])
            let response = try await service.fetchRecipes(request: request)
            let newRecipes = response?.recipes ?? []
            totalRecipesCount = response?.total ?? 0
            self.recipes.append(contentsOf: newRecipes)
        } catch(let error) {
            errorMessage = "Failed to fetch recipes \(error.localizedDescription)"
        }

        isLoading = false
    }

    func refreshRecipes() async {
        recipes.removeAll()
        totalRecipesCount = -1
        await fetchRecipes()
    }
}
