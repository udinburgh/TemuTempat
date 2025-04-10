//
//  ProfileImageView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 09/04/25.
//

import SwiftUI
import PhotosUI

struct ProfileImageView: View {
    // Color definitions
    let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    let lightBlue = Color(red: 0.9, green: 0.95, blue: 1.0)
    
    // State variables
    @Binding var profileImage: Image?
    @Binding var showChangeButton: Bool
    @Binding var selectedItem: PhotosPickerItem?
    
    var body: some View {
        ZStack {
            // Profile image or placeholder
            if let image = profileImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(primaryBlue, lineWidth: 2))
            } else {
                Circle()
                    .fill(lightBlue)
                    .frame(width: 100, height: 100)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundColor(primaryBlue)
                    )
                    .overlay(Circle().stroke(primaryBlue, lineWidth: 2))
            }
            
            // Change button
            if showChangeButton {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Circle()
                        .fill(primaryBlue)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: "camera.fill")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                        )
                        .offset(x: 30, y: 30)
                }
                .buttonStyle(.plain)
            }
        }
        .onTapGesture {
            withAnimation {
                showChangeButton.toggle()
            }
        }
    }
}
