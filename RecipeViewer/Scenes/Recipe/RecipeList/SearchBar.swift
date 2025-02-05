//
//  SearchBar.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search Recipes...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityIdentifier("searchBar")
        }
    }
}
