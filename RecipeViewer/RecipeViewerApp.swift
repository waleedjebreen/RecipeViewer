//
//  RecipeViewerApp.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import SwiftUI

@main
struct RecipeViewerApp: App {
    
    let netWorkManager: NetworkManager
    let recipiesListViewModel: RecipeViewModel
    
    init() {
        netWorkManager = NetworkManager(baseURL: URL(string: "https://dummyjson.com")!)
        recipiesListViewModel = RecipeViewModel(service: RecipeService(networkManager: netWorkManager))
    }
    
    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: recipiesListViewModel)
        }
    }
}
