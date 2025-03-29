//
//  MapView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 26/03/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(ModelData.self) var modelData
    
    @State var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.301616, longitude: 106.651796),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.005)
    ))
    
    @State private var selectedPlace: Places?
    @State private var searchTerm: String = ""
    
//    var userPosition = MapCameraPosition.userLocation
    
    var searchedPlaces: [Places] {
        if searchTerm.isEmpty {
            return modelData.places // Show all places when search is empty
        } else {
            return modelData.places.filter { place in
                place.name.lowercased().contains(searchTerm.lowercased()) // Case-insensitive search by name
            }
        }
    }
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(modelData.places) { place in
                    Annotation(place.name, coordinate: place.locationCoordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                selectedPlace = place
                            }
                    }
                }
            }
            .ignoresSafeArea()
            
            // Bottom sheet is now positioned by its own internal logic
            if let selectedPlace = selectedPlace {
                BottomSheet(places: [selectedPlace])
                    .transition(.move(edge: .bottom))
            } else {
                BottomSheet(places: searchedPlaces)
                    .transition(.move(edge: .bottom))
            }
            
            VStack {
                SearchBar(searchTerm: $searchTerm)
                    .padding(.horizontal)
                    .padding(.top)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                Spacer()
            }
        }
        .onChange(of: searchTerm) { oldValue, newValue in
            // Reset selectedPlace to nil when searchTerm changes
            if !newValue.isEmpty {
                selectedPlace = nil
            }
        }
    }
}

#Preview {
    let modelData = ModelData()
    MapView()
        .environment(modelData)
}
