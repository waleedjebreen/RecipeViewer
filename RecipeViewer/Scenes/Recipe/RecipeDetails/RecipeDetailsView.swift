//
//  RecipeDetailsView.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import SwiftUI
import Kingfisher

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                KFImage(URL(string: recipe.getImage()))
                    .placeholder({
                        ProgressView()
                    })
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(recipe.getName())
                        .font(.largeTitle)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ingredients:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        Text(recipe.getIngredients())
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Instructions:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        ForEach(Array(recipe.getInstructions().enumerated()), id: \.element) { index, instruction in
                            Text("\(index + 1)· \(instruction)")
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                
            }
            .padding()
        }
    }
}
