//
//  PlaceDetailView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 28/03/25.
//

import SwiftUI

struct PlaceDetails: View {
    @Environment(ModelData.self) var modelData
    let selectedPlace: Places
    
    var placeIndex: Int {
        modelData.places.firstIndex(where : { $0.id == selectedPlace.id })!
    }
    
    @State private var isLoved = false
    
    var body: some View {
        @Bindable var modelData = modelData
        // Show details when a place is selected
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                selectedPlace.image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    HStack {
                        Text(selectedPlace.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        FavoriteButton(isLoved: $modelData.places[placeIndex].isFavorite)
                    }
                    Text("Address: \(selectedPlace.address)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        ForEach(selectedPlace.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(5)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(5)
                        }
                    }
                }
            }
            Text(selectedPlace.description)
                .font(.body)
        }
        .padding()
        .transition(.opacity)
    }
}

#Preview {
    let modelData = ModelData()
    PlaceDetails(selectedPlace: modelData.places[0])
        .environment(modelData)
}
