//
//  FavoritesView.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Query(filter: #Predicate<Building> { $0.isFavorite }) var favoritedBuildings: [Building]
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(favoritedBuildings) { building in
                    BuildingCard(building: building)
                    }
                    .padding()
                }
            }
        }
    }

#Preview {
    FavoriteView()
        .modelContainer(for: Building.self, inMemory: true)
}
