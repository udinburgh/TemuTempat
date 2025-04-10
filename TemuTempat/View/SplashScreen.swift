//
//  SplashScreen.swift
//  TemuTempat
//
//  Created by Akbar Febry on 10/04/25.
//

import SwiftUI
import SwiftData

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
                .modelContainer(for: Building.self)
        } else {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .ignoresSafeArea()
            .onAppear {
                // Delay 2 detik sebelum masuk ContentView
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
        .modelContainer(for: Building.self)
}
