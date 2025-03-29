//
//  HomeView.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI
import MapKit

struct HomeView: View {
    var body: some View {
        let modelData = ModelData()
        MapView()
                .environment(modelData)
    }
}

#Preview {
    HomeView()
}
