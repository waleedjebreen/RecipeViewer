//
//  RecipeViewerApp.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import SwiftUI

@main
struct RecipeViewerApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: RecipeViewModel(service: RecipeService(networkManager: NetworkManager(baseURL: URL(string: "https://dummyjson.com")!))))
        }
    }
}
