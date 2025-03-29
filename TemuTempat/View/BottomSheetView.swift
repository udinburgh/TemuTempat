//
//  BottomSheet 2.swift
//  TemuTempat
//
//  Created by Akbar Febry on 26/03/25.
//

import SwiftUI

struct BottomSheet: View {
    var places: [Places]
    @State private var selectedPlace: Places? // Track the selected place
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 10)
            
                HStack {
                    Text("Explore")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                    if selectedPlace != nil {
                    Spacer()
                    Button(action: {
                        self.selectedPlace = nil // Deselect to return to list
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.title2)
                            .padding(.trailing, 20)
                    }
                }
            }
            
            ScrollView {
                if let selectedPlace = selectedPlace {
                    PlaceDetails(selectedPlace: selectedPlace)
                } else {
                    // Show list of cards when no place is selected
                    VStack {
                        ForEach(places) { place in
                            PlacesCard(places: place)
                                .onTapGesture {
                                    selectedPlace = place // Select the tapped place
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 30)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
        .offset(y: UIScreen.main.bounds.height * 0.45)
        .animation(.easeInOut, value: selectedPlace) // Animate the switch
    }
}

#Preview {
    let modelData = ModelData()
    BottomSheet(places: modelData.places)
        .environment(modelData)
}
