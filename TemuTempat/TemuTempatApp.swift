//
//  TemuTempatApp.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI

@main
struct TemuTempatApp: App {
    var body: some Scene {
        WindowGroup {
            let modelData = ModelData()
            ContentView()
                .environment(modelData)
        }
    }
}
