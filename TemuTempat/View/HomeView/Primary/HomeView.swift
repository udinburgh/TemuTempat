//
//  HomeView.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI
import MapKit
import SwiftData

struct HomeView: View {
    var body: some View {
        MapView()
            .modelContainer(for: Building.self, inMemory: true)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Building.self, inMemory: true)
}
