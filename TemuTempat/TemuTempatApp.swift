//
//  TemuTempatApp.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI
import SwiftData

@main
struct TemuTempatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Building.self)
        }
    }
}
