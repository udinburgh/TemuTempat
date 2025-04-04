//
//  BuildingsCardView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 27/03/25.
//

import SwiftUI

struct BuildingCard: View {
    var building: Building
    
    var body: some View {
        VStack {
            HStack {
                building.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(building.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        
                        FavoriteButton(isLoved: Binding(
                            get: { building.isFavorite },
                            set: { building.isFavorite = $0 }
                        ))
                    }
                    
                    Text(building.desc)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        ForEach(building.tags, id: \.self) { tag in
                            Text(tag)
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
