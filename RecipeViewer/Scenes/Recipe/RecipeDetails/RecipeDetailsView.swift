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
                    VStack(alignment: .leading, spacing: 0) {
                        Text(recipe.getName())
                            .font(.largeTitle)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityIdentifier("recipeName")
                        
                        Text(recipe.getTags())
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityIdentifier("recipeTags")
                        
                        HStack {
                            InfoView(title: "Rating", iconName: "star.fill", iconColor: .yellow, value: "\(recipe.getRating())")

                            InfoView(title: "Prep", iconName: "clock", iconColor: .brown, value: "\(recipe.prepTimeMinutes ?? 0) min")
                            
                            InfoView(title: "Cook", iconName: "clock.badge.checkmark", iconColor: .green, value: "\(recipe.cookTimeMinutes ?? 0) min")
                            
                            InfoView(title: "Difficulty", iconName: "gearshape", iconColor: .black, value: "\(recipe.difficulty ?? "")")
                        }
                        .padding(.horizontal, 8)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(.yellow))
                                .opacity(0.1)
                        )
                        .padding(.top, 12)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ingredients:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .accessibilityIdentifier("recipeIngredients")
                        
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
                                .accessibilityIdentifier("instruction_\(index + 1)")
                        }
                    }
                }
                
            }
            .padding()
        }
        .accessibilityIdentifier("recipeDetailsScrollView")
    }
}
