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
            ZStack {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.headline)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        HStack(spacing: 8) {
                            Text("Sorting")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .accessibilityIdentifier("sortPicker")
                            
                            Picker("Sort By", selection: $viewModel.sortOption) {
                                Text("None")
                                    .tag(RecipeViewModel.SortOption.none)
                                    .accessibility(addTraits: .isButton)
                                Text("A-Z")
                                    .tag(RecipeViewModel.SortOption.alphabetical)
                                    .accessibility(addTraits: .isButton)
                                Text("Z-A")
                                    .tag(RecipeViewModel.SortOption.reverseAlphabetical)
                                    .accessibility(addTraits: .isButton)
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding(.horizontal, 8)
                        
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.recipes, id: \.id) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeRow(recipe: recipe)
                                        .onAppear {
                                            if recipe == viewModel.recipes.last {
                                                viewModel.fetch(isLoadMore: true)
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.vertical, 12)
                    }
                }
                .refreshable {
                    viewModel.refreshRecipes()
                }
                .searchable(text: $viewModel.searchText)
                .onSubmit(of: .search) {
                    viewModel.refreshRecipes()
                }
                .onChange(of: viewModel.sortOption) {
                    viewModel.refreshRecipes()
                }
                .onChange(of: viewModel.searchText) { oldValue, newValue in
                    if !oldValue.isEmpty && newValue.isEmpty {
                        viewModel.refreshRecipes()
                    }
                }
                .accessibilityIdentifier("recipeListScrollView")
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            
            .navigationTitle("Recipes")
        }
    }
}





