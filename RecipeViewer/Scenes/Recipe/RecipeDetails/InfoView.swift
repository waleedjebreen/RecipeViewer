//
//  InfoView.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import SwiftUI

struct InfoView: View {
    
    let title: String
    let iconName: String
    let iconColor: Color
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.footnote)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack(spacing: 4) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(iconColor)
                
                Text(value)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}
