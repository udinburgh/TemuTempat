//
//  ContentView.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "mappin.circle")
                    Text("Map")
                }
            ChallengeView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Challenge")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    let modelData = ModelData()
    ContentView()
        .environment(modelData)
}
