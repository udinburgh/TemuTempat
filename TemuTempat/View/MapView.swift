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
    var places: Places
    
    var placesIndex: Int {
        modelData.places.firstIndex(where : { $0.id == places.id })!
    }
    
    @State var position =  MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.301616, longitude: 106.651796),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.005)
    ))
    
    @State private var selectedPlace: Places?
    
    var userPosition = MapCameraPosition.userLocation
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $position) {
                    ForEach(modelData.places) { place in
                        Annotation(place.name, coordinate: place.locationCoordinate) {
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    selectedPlace = place
                                }
                        }
                    }
                }
//                .navigationDestination(isPresented: Binding(
//                                get: { selectedPlace != nil },
//                                set: { if !$0 { selectedPlace = nil } }
//                            )) {
//                                if let selectedPlace = selectedPlace {
//                                    BottomSheet()
//                                }
//                            }
                BottomSheet()
            }
        }
    }
}

#Preview {
    let modelData = ModelData()
        MapView(places: modelData.places[0])
            .environment(modelData)
    }

