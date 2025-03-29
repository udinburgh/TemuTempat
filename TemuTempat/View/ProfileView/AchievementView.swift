//
//  AchievementView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 29/03/25.
//

import SwiftUI

struct AchievementView: View {
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AchievementRow(title: "Bronze Medal", progress: min(max(Double(completedChallenges) / 2.0, 0.0), 1.0), total: 2, color: .brown)
                AchievementRow(title: "Silver Medal", progress: min(max(Double(completedChallenges) / 5.0, 0.0), 1.0), total: 5, color: .gray)
                AchievementRow(title: "Gold Medal", progress: min(max(Double(completedChallenges) / 10.0, 0.0), 1.0), total: 10, color: .yellow)
            }
            .padding()
        }
    }
}


struct AchievementRow: View {
    var title: String
    var progress: Double
    var total: Int
    var color: Color

    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(color)
                )

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                
                Text("\(Int(progress * Double(total))) / \(total) Challenges Completed")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 150)
                    .tint(color) // Menyesuaikan warna progress bar dengan pencapaian
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
