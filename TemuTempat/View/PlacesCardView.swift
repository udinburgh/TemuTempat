//
//  PlacesCardView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 27/03/25.
//

import SwiftUI

struct PlacesCard: View {
    @Environment(ModelData.self) var modelData
    var places: Places
    @State private var isLoved = false
    
    var body: some View {
        @Bindable var modelData = modelData
        VStack {
            HStack {
                places.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(places.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        
                        Button {
                            isLoved.toggle()
                        } label: {
                            Label("Toggle Favorite", systemImage: isLoved ? "heart.fill" : "heart")
                                .labelStyle(.iconOnly)
                                .foregroundStyle(isLoved ? .red : .gray)
                        }
                    }
                    
                    Text(places.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        ForEach(places.tags, id: \.self) { tags in
                            Text(tags)
                                .font(.system(size: 12))
                                .padding(5)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(5)
                        }
                    }
                }
            }
            .padding()
            
            Divider()
        }
    }
}

#Preview {
    let modelData = ModelData()
    PlacesCard(places: modelData.places[0])
        .environment(modelData)
}
