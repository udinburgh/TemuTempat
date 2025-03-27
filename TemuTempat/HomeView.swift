//
//  HomeView.swift
//  Coba Coba
//
//  Created by Cynthia Shabrina on 19/03/25.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @Binding var searchTerm: String
    var places: [Places]
    
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: -6.301387, longitude: 106.652034), latitudinalMeters: 500, longitudinalMeters: 500))
    
    var body: some View {
            ZStack {
                VStack {
                    Map(initialPosition: cameraPosition)
                }
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 10)

                            TextField("Search here...", text: $searchTerm)
                                .padding(10)
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 650)
                }
                BottomSheet(places: places)
            }
        }
    }


#Preview {
    struct PreviewWrapper: View {
        @State private var searchTerm = ""
        let samplePlaces: [Places] = [] 

        var body: some View {
            HomeView(searchTerm: $searchTerm, places: samplePlaces)
        }
    }
    return PreviewWrapper()
}
