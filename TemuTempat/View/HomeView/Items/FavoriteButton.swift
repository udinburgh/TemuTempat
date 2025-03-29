//
//  FavoriteButton.swift
//  TemuTempat
//
//  Created by Akbar Febry on 29/03/25.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isLoved: Bool
    
    var body: some View {
        Button {
            isLoved.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isLoved ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundStyle(isLoved ? .red : .gray)
        }
    }
}

#Preview {
    FavoriteButton(isLoved: .constant(true))
}
