//
//  AchievementView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 29/03/25.
//

import SwiftUI

struct AchievementView: View {
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0
    
    // Define our blue color palette
    private let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    private let lightBlue = Color(red: 0.9, green: 0.95, blue: 1.0)
    
    // Medal colors
    private let bronzeColor = Color(red: 0.8, green: 0.5, blue: 0.2)
    private let silverColor = Color(red: 0.75, green: 0.75, blue: 0.8)
    private let goldColor = Color(red: 1.0, green: 0.85, blue: 0.0)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("Your Achievements")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Achievement cards
                SimplifiedAchievementCard(
                    title: "Bronze Medal",
                    description: "Complete 2 challenges",
                    progress: min(max(Double(completedChallenges) / 2.0, 0.0), 1.0),
                    total: 2,
                    color: bronzeColor,
                    icon: "medal"
                )
                
                SimplifiedAchievementCard(
                    title: "Silver Medal",
                    description: "Complete 5 challenges",
                    progress: min(max(Double(completedChallenges) / 5.0, 0.0), 1.0),
                    total: 5,
                    color: silverColor,
                    icon: "medal.fill"
                )
                
                SimplifiedAchievementCard(
                    title: "Gold Medal",
                    description: "Complete 10 challenges",
                    progress: min(max(Double(completedChallenges) / 10.0, 0.0), 1.0),
                    total: 10,
                    color: goldColor,
                    icon: "crown.fill"
                )
            }
            .padding(.horizontal)
        }
    }
}

struct SimplifiedAchievementCard: View {
    var title: String
    var description: String
    var progress: Double
    var total: Int
    var color: Color
    var icon: String
    
    var isCompleted: Bool {
        progress >= 1.0
    }
    
    var body: some View {
        HStack {
            // Medal icon
            ZStack {
                Circle()
                    .fill(isCompleted ? color.opacity(0.2) : Color.gray.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 25))
                    .foregroundColor(isCompleted ? color : Color.gray.opacity(0.5))
            }
            
            // Achievement details
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Progress indicator
                HStack {
                    Text("\(Int(progress * Double(total))) / \(total)")
                        .font(.caption)
                        .foregroundColor(isCompleted ? color : .gray)
                    
                    Spacer()
                    
                    if isCompleted {
                        Text("Completed!")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(color)
                    }
                }
                
                // Progress bar
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(color)
            }
            .padding(.leading, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isCompleted ? color.opacity(0.3) : Color.clear, lineWidth: 1)
        )
    }
}

#Preview {
    AchievementView()
}
