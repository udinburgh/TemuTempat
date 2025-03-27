//
//  HistoryView.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI

struct HistoryView: View {
    
    @State var isFavorite: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<9) { _ in
                    HStack {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text("Place Name")
                                .font(.headline)
                            Text("Place Address")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            HStack {
                                ForEach(0..<3) { _ in
                                    Text("tags")
                                        .font(.subheadline)
                                        .padding(4)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(5)
                                }
                            }
                        }
                        Spacer()
                        Button {
                            withAnimation(.default){
                                isFavorite.toggle()
                            }
                        } label: {
                            Image(systemName: isFavorite ? "heart" : "heart.fill")
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HistoryView()
}
