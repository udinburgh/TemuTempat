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
    
    @State private var isShowingDetails: Bool = false
    @State private var selectedBuilding: Building =             Building(
        id: 1,
        name: "Green Office Park 9",
        desc: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.",
        isFavorite: false,
        address: "Address 2",
        tags: ["GOP 9"],
        imageName: "gop9",
        coordinates: Building.Coordinates(latitude: -6.3023062, longitude: 106.6522011)
    )
    
    // Define our blue color palette
    private let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    private let lightBlue = Color(red: 0.9, green: 0.95, blue: 1.0)
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Favorites")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Places you've saved")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                if favoritedBuildings.isEmpty {
                    // Empty state
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Image(systemName: "heart.slash")
                            .font(.system(size: 60))
                            .foregroundColor(primaryBlue.opacity(0.3))
                        
                        Text("No favorites yet")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Places you mark as favorite will appear here")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Spacer()
                    }
                } else {
                    // List of favorites
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(favoritedBuildings) { building in
                                Button(action: {
                                    selectedBuilding = building
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        isShowingDetails = true
                                    }                                }) {
                                    BuildingCard(building: building, primaryBlue: primaryBlue, lightBlue: lightBlue)
                                }
                                .buttonStyle(PlainButtonStyle())

                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingDetails) {
            BuildingDetailsFullScreen(
                selectedBuilding: $selectedBuilding,
                isPresented: $isShowingDetails
            )
        }
    }
}


#Preview {
    FavoriteView()
        .modelContainer(for: Building.self)
}
