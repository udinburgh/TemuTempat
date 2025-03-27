//
//  BottomSheet 2.swift
//  TemuTempat
//
//  Created by Akbar Febry on 26/03/25.
//

import SwiftUI

struct BottomSheet: View {
    
    var places: [Places]
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 10)
            
            ScrollView {
                VStack {
                    ForEach(places) { place in
                        PlacesCard(places: place)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 30)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
        .offset(y: UIScreen.main.bounds.height * 0.45)
    }
}

#Preview {
    let modelData = ModelData()
    BottomSheet(places: modelData.places)
        .environment(modelData)
}
