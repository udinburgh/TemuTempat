//
//  BottomSheet 2.swift
//  TemuTempat
//
//  Created by Akbar Febry on 26/03/25.
//

import SwiftUI

struct BottomSheet: View {
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 10)
            
            ScrollView {
                ForEach(0..<20) { _ in
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
                                        .padding(5)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(5)
                                }
                            }
                        }
                        Spacer()
                        
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            .padding(.bottom,30)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxHeight: UIScreen.main.bounds.height * 5)
        .offset(y: UIScreen.main.bounds.height * 0.50) // Adjusted offset to move it slightly higher
    }
}
