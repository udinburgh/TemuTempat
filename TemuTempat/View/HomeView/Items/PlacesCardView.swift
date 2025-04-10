//
//  BuildingCard.swift
//  TemuTempat
//
//  Created by Akbar Febry on 09/04/25.
//
import SwiftUI


// Modern version of BuildingCard
// Modern version of BuildingCard
struct BuildingCard: View {
    let building: Building
    let primaryBlue: Color
    let lightBlue: Color
    
    var body: some View {
        HStack(spacing: 16) {
            // Building image
            ZStack {
                Rectangle()
                    .fill(lightBlue)
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                
                building.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                    .clipped()
            }
            
            // Building details
            VStack(alignment: .leading, spacing: 6) {
                Text(building.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Text(building.address)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                // Tags
                if !building.tags.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(building.tags.prefix(3), id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 12))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(lightBlue)
                                .foregroundColor(primaryBlue)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            
            Spacer()
            
            // Favorite indicator
            FavoriteButton(isLoved: Binding(
                get: { building.isFavorite },
                set: { building.isFavorite = $0 }
            ))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}
