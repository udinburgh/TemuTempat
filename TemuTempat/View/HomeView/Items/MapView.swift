//
//  MapView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 26/03/25.
//

import SwiftUI
import MapKit
import SwiftData

struct MapView: View {
    @Query var buildings: [Building]
    @Query var places: [Place]
    
    @Environment(\.modelContext) private var context
    
    @State var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.301616, longitude: 106.651796),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.005)
    ))
    
    @State private var selectedBuilding: Building?
    @State private var searchTerm: String = ""
    
//    var userPosition = MapCameraPosition.userLocation
    
    var searchedBuildings: [Building] {
        if searchTerm.isEmpty {
            return buildings // Show all buildings when search is empty
        } else {
            return buildings.filter { building in
                building.name.lowercased().contains(searchTerm.lowercased()) // Case-insensitive search by name
            }
        }
    }
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(buildings) { building in
                    if building.locationCoordinate != nil {
                        Annotation(building.name, coordinate: building.locationCoordinate!) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.red)
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    selectedBuilding = building
                                }
                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            // Bottom sheet is now positioned by its own internal logic
            if let selectedBuilding = selectedBuilding {
                BottomSheet(buildings: [selectedBuilding])
                    .transition(.move(edge: .bottom))
            } else {
                BottomSheet(buildings: searchedBuildings)
                    .transition(.move(edge: .bottom))
            }
            
            VStack {
                SearchBar(searchTerm: $searchTerm)
                    .padding(.top, 20)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
        .onChange(of: searchTerm) { oldValue, newValue in
            // Reset selectedBuilding to nil when searchTerm changes
            if !newValue.isEmpty {
                selectedBuilding = nil
            }
        }
    }
}

#Preview {
    MapView()
        .modelContainer(for: Building.self, inMemory: true)
}
