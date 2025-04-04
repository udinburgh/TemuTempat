//
//  BuildingDetailView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 28/03/25.
//

import SwiftUI

struct BuildingDetails: View {
    let selectedBuilding: Building
    
    var body: some View {
        // Show details when a building is selected
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                selectedBuilding.image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    HStack {
                        Text(selectedBuilding.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        FavoriteButton(isLoved: Binding(
                            get: { selectedBuilding.isFavorite },
                            set: { selectedBuilding.isFavorite = $0 }
                        ))
                    }
                    Text("Address: \(selectedBuilding.address)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        ForEach(selectedBuilding.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(5)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(5)
                        }
                    }
                }
            }
            Text(selectedBuilding.desc)
                .font(.body)
        }
        .padding()
        .transition(.opacity)
    }
}
