//
//  RecipeListView.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import SwiftUI
import Kingfisher

struct RecipeListView: View {
    @StateObject var viewModel: RecipeViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                SearchBar(text: $viewModel.searchText)
                    .padding(.horizontal, 8)
                
                HStack(spacing: 8) {
                    Text("Sorting")
                        .font(.footnote)
                        .fontWeight(.medium)
                    Picker("Sort By", selection: $viewModel.sortOption) {
                        Text("None")
                            .tag(RecipeViewModel.SortOption.none)
                        Text("A-Z")
                            .tag(RecipeViewModel.SortOption.alphabetical)
                        Text("Z-A")
                            .tag(RecipeViewModel.SortOption.reverseAlphabetical)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 8)
                
                ZStack {
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.headline)
                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.filteredRecipes, id: \.id) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeRow(recipe: recipe)
                                        .onAppear {
                                            if recipe == viewModel.recipes.last {
                                                Task {
                                                    await viewModel.fetchRecipes()
                                                }
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.vertical, 12)
                    }
                    .refreshable {
                        await Task {
                            await viewModel.refreshRecipes()
                        }.value
                    }
                    
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                    }
                }
                .navigationDestination(for: Recipe.self) { recipe in
                    RecipeDetailView(recipe: recipe)
                }
            }
            .navigationTitle("Recipes")
        }
    }
}





