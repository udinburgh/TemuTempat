//
//  PlaceCard.swift
//  TemuTempat
//
//  Created by Cynthia Shabrina on 27/03/25.
//

import SwiftUI

struct PlacesCard: View {
    var places: Places
    @State private var isLoved = false
    @State private var loveCount = 0
    
    var body: some View {
        VStack {
            HStack {
                Image(places.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(places.placeName)
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        Text("\(loveCount)")
                        
                        Button(action: toggleLove) {
                            Image(systemName: isLoved ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundColor(isLoved ? .pink : .gray)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    Text(places.placeDescription)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text(places.tags)
                            .font(.system(size: 12))
                            .padding(5)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(5)
                    }
                }
            }
            .padding()
            
            Divider()
        }
    }

    func toggleLove() {
        if isLoved {
            loveCount -= 1
        } else {
            loveCount += 1
        }
        isLoved.toggle()
    }
}

#Preview {
    PlacesCard(places: Places(placeName: "Cinema XXI", imageName:"CinemaXX1", placeDescription:"Cinema XXI, destinasi utama menonton film Anda.", tags:"Watching"))
}
