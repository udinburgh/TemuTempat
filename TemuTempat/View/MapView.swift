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
    
    @State var position =  MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.301616, longitude: 106.651796),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.005)
    ))
    
    @State private var selectedPlace: Places?
    @State private var searchTerm: String = ""
    
    var userPosition = MapCameraPosition.userLocation
    
    var body: some View {
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
//                .navigationDestination(isPresented: Binding(
//                                get: { selectedPlace != nil },
//                                set: { if !$0 { selectedPlace = nil } }
//                            )) {
//                                if let selectedPlace = selectedPlace {
//                                    BottomSheet()
//                                }
//                            }
            }
            if selectedPlace == nil {
                BottomSheet(places: modelData.places)
            } else {
                BottomSheet(places: [selectedPlace!])
            }
        }
    }
}

#Preview {
    let modelData = ModelData()
    MapView()
            .environment(modelData)
    }

