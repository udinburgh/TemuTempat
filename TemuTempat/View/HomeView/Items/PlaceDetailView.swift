//
//  BuildingDetailView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 28/03/25.
//

import SwiftUI

struct BuildingDetails: View {
    @State var selectedBuilding: Building // Note: pakai @State kalau mau FavoriteButton bisa update

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            selectedBuilding.image
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(12)
            
            HStack{
                Text(selectedBuilding.name)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                FavoriteButton(isLoved: Binding(
                    get: { selectedBuilding.isFavorite },
                    set: { selectedBuilding.isFavorite = $0 }
                ))
            }
            .frame(maxWidth: .infinity, alignment: .leading) // supaya buttonnya kiri
            
            Text("Address: \(selectedBuilding.address)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // Tags
            Text(selectedBuilding.desc)
                .font(.body)
                .padding(.top, 2)
            
            Spacer()
        }
        .padding()
        .transition(.opacity)
    }
}

#Preview {
    BuildingDetails(selectedBuilding: Building(
        id: 2401,
        name: "Lawson",
        desc: "Lawson, Inc. is a Japanese convenience store franchise chain. Lawson offers a wide variety of snacks and drinks to choose from. It’s well-known for its oden, choux, tteokbokki, and onigiri. A while back, their snack tray combo—a mix of drinks and light bites—went pretty viral too. Lawson also has some cool deals to help you shop smarter; check out their official social media for more details.",
        isFavorite: false,
        address: "Lt. B1 Gedung GOP 6",
        tags: ["food", "drink", "GOP 6"],
        imageName: "lawson"
    ))
    .padding()
}
