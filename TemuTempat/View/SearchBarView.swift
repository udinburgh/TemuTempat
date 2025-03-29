//
//  SearchBarView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 27/03/25.
//
import SwiftUI

struct SearchBar: View {
    @Binding var searchTerm: String
    
    var body : some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 20)
            
            TextField("Search here...", text: $searchTerm)
                .padding(10)
            if !searchTerm.isEmpty {
                Button {
                    searchTerm = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                }

            }
        }
        .background(Color.white)
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
        .shadow(radius: 5)
    }
}

#Preview {
    SearchBar(searchTerm: .constant(""))
}
