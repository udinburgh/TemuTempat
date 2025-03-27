import SwiftUI

struct AchievementView: View {
    var completedChallenges: Int
    
    var achievement: String {
        switch completedChallenges {
        case 10...:
            return "Gold Medal"
        case 5..<10:
            return "Silver Medal"
        case 2..<5:
            return "Bronze Medal"
        default:
            return "No Medal Yet"
        }
    }
    
    var progress: Double {
        Double(completedChallenges) / 10.0
    }
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text(achievement)
                        .font(.headline)
                    Text("Complete challenges to earn medals!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle())
                }
                .padding()
            }
            .padding()
        }
    }
}
