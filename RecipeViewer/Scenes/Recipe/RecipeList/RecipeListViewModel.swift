//
//  RecipeListViewModel.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published private var recipesList: [Recipe] = []
    @Published private var filteredRecipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .none
    var isSearching: Bool {
        !searchText.isEmpty || sortOption != .none
    }
    var recipes: [Recipe] {
        isSearching ? filteredRecipes : recipesList
    }

    var totalRecipesCount: Int = -1

    private let service: RecipeServiceProtocol

    init(service: RecipeServiceProtocol) {
        self.service = service
        
        fetch()
    }

    enum SortOption: String {
        case alphabetical = "asc"
        case reverseAlphabetical = "desc"
        case none
    }

    func fetch(isLoadMore: Bool = false) {
        if isSearching {
            Task {
                await searchRecipes(isLoadMore: isLoadMore)
            }
        } else {
            Task {
                await fetchRecipes(isLoadMore: isLoadMore)
            }
        }
    }
    
    private func fetchRecipes(isLoadMore: Bool = false) async {
        guard self.recipesList.count != totalRecipesCount else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.fetchRecipes(request: RecipeModule.recipiesList(limit: 10, skip: recipesList.count))
            let newRecipes = response?.recipes ?? []
            totalRecipesCount = response?.total ?? 0
            if isLoadMore {
                self.recipesList.append(contentsOf: newRecipes)
            } else {
                self.recipesList = newRecipes
            }
        } catch(let error) {
            errorMessage = "Failed to fetch recipes \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func searchRecipes(isLoadMore: Bool) async {
        if filteredRecipes.isEmpty {
            totalRecipesCount = -1
        }
        guard self.filteredRecipes.count != totalRecipesCount else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.fetchRecipes(
                request: RecipeModule.searchRecipes(
                    query: searchText.isEmpty ? nil : searchText,
                    sortOption: sortOption == .none ? nil : sortOption.rawValue,
                    limit: 10,
                    skip: filteredRecipes.count
                )
            )
            let newRecipes = response?.recipes ?? []
            totalRecipesCount = response?.total ?? 0
            if isLoadMore {
                self.filteredRecipes.append(contentsOf: newRecipes)
            } else {
                self.filteredRecipes = newRecipes
            }
        } catch(let error) {
            errorMessage = "Failed to fetch recipes \(error.localizedDescription)"
        }
        
        isLoading = false
    }

    func refreshRecipes() {
        isSearching ? filteredRecipes.removeAll() : recipesList.removeAll()
        totalRecipesCount = -1
        fetch()
    }
}
