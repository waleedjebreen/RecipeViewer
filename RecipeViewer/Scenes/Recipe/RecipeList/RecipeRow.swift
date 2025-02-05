//
//  RecipeRow.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import SwiftUI
import Kingfisher

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 0) {
            VStack {
                KFImage(URL(string: recipe.getImage()))
                    .placeholder({
                        ProgressView()
                    })
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .transition(.opacity)
                    .padding(.horizontal, 8)
                
                Spacer()
            }

            VStack(alignment: .leading) {
                Text(recipe.getName())
                    .font(.headline)
                    .foregroundColor(.primary)
                    .animation(.easeInOut(duration: 0.3), value: recipe.getName())

                Text(recipe.getIngredients())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
            .fill(Color(.white))
            .shadow(radius: 3)
        )
        .padding(.horizontal, 10)
    }
}
