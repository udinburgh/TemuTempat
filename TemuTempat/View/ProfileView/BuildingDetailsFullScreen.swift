//
//  BuildingDetailsFullScreen.swift
//  TemuTempat
//
//  Created by Akbar Febry on 10/04/25.
//

import SwiftUI

struct BuildingDetailsFullScreen: View {
    @Binding var selectedBuilding: Building
    @Binding var isPresented: Bool
    

    var body: some View {
        ZStack(alignment: .topTrailing) {

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                }
                
                selectedBuilding.image
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .cornerRadius(12)
                    .padding(.top, 16)
                    .padding(.horizontal, 26)
                
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
            .transition(.opacity)// avoid notch
        }
    }
}
