//
//  ProfileStatsView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 09/04/25.
//

import SwiftUI

struct ProfileStatsView: View {
    // Color definitions
    let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    let lightBlue = Color(red: 0.9, green: 0.95, blue: 1.0)
    
    // Variables
    let completedChallenges: Int
    let medals: Int
    
    var body: some View {
        HStack(spacing: 40) {
            VStack {
                Text("\(completedChallenges)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(primaryBlue)
                
                Text("Challenges")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            VStack {
                Text("\(medals)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(primaryBlue)
                
                Text("Medals")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(lightBlue)
        .cornerRadius(10)
    }
}
