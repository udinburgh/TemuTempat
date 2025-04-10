//
//  ProfileNameView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 09/04/25.
//

import SwiftUI

struct ProfileNameView: View {
    // Color definition
    let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    
    // State variables
    @Binding var userName: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            if isEditing {
                TextField("Enter name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                
                Button("Save") {
                    isEditing = false
                }
                .foregroundColor(primaryBlue)
            } else {
                Text(userName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Button {
                    isEditing = true
                } label: {
                    Image(systemName: "pencil")
                        .foregroundColor(primaryBlue)
                }
            }
        }
    }
}
