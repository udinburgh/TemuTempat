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
//        ZStack {
//            MapView(searchTerm: .constant(""))
//            SearchBar()
//                .padding(.horizontal)
//                .padding(.bottom, 650)
//        }
        Text("Hello, World!")
    }
}

#Preview {
    let modelData = ModelData()
    ContentView()
        .environment(modelData)
}
