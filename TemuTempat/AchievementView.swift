import SwiftUI

struct AchievementView: View {
    var completedChallenges: Int
    
    var body: some View {
        VStack {
            Text("Achievements")
                .font(.headline)
                .padding()
            
            HStack(spacing: 20) {
                MedalView(title: "Gold Medal", color: .yellow)
                MedalView(title: "Silver Medal", color: .gray)
                MedalView(title: "Bronze Medal", color: .brown)
            }
            .padding()
        }
    }
}

struct MedalView: View {
    var title: String
    var color: Color
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color.opacity(0.8))
                .frame(width: 80, height: 80)
                .overlay(Text(title.prefix(1))
                            .font(.largeTitle)
                            .foregroundColor(.white))
            
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
        }
    }
}
