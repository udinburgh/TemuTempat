//
//  ProfileTabsView.swift
//  TemuTempat
//

import SwiftUI

struct ProfileTabsView: View {
    // State variable
    @Binding var selectedFilter: ProfileFilter
    
    // Color definitions
    private let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    private let lightBlue = Color(red: 0.9, green: 0.95, blue: 1.0)
    
    var body: some View {
        HStack {
            // Achievements Tab
            tabButton(
                title: "Achievements",
                isSelected: selectedFilter == .Achievements,
                action: { selectedFilter = .Achievements }
            )
            
            // Favorites Tab
            tabButton(
                title: "Favorites",
                isSelected: selectedFilter == .Favorites,
                action: { selectedFilter = .Favorites }
            )
        }
        .padding(.vertical, 10)
    }
    
    // Helper function to create a tab button
    private func tabButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .foregroundColor(isSelected ? primaryBlue : .gray)
                .background(isSelected ? lightBlue : Color.clear)
                .cornerRadius(8)
        }
        .frame(maxWidth: .infinity)
    }
}
