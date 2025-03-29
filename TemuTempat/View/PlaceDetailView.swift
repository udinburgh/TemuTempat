//
//  PlaceDetailView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 28/03/25.
//

import SwiftUI

struct PlaceDetails: View {
    let selectedPlace: Places
    
    @State private var isLoved = false
    
    var body: some View {
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
                        Button {
                            isLoved.toggle()
                        } label: {
                            Label("Toggle Favorite", systemImage: isLoved ? "heart.fill" : "heart")
                                .labelStyle(.iconOnly)
                                .foregroundStyle(isLoved ? .red : .gray)
                        }
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
