import SwiftUI

struct ChallengeView: View {
    @State private var completedChallenges: Int = 0
    let challenges = ["Challenge A", "Challenge B", "Challenge C", "Challenge D", "Challenge E", "Challenge F"]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Challenge")
                    .font(.largeTitle)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(challenges, id: \ .self) { challenge in
                        VStack {
                            Text(challenge)
                                .font(.headline)
                                .padding(.top)
                            
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                .font(.caption)
                                .padding()
                            
                            NavigationLink(destination: QuizView(challenge: challenge, completedChallenges: $completedChallenges)) {
                                Text("Start Challenge")
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                        .frame(width: 170, height: 200)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}

struct QuizView: View {
    let challenge: String
    @Binding var completedChallenges: Int
    
    @State private var selectedAnswer: Int? = nil
    @State private var questionIndex: Int = 0
    @State private var score: Int = 0
    @State private var showResult: Bool = false
    
    let challengeQuestions: [String: [(question: String, answers: [String], correctAnswer: Int)]] = [
        "Challenge A": [
            ("Kucing termasuk hewan apa?", ["Mamalia", "Reptil", "Amfibi", "Ikan"], 0),
            ("Berapa kaki laba-laba?", ["4", "6", "8", "10"], 2)
        ],
        "Challenge B": [
            ("Apa warna khas panda?", ["Coklat", "Hitam Putih", "Abu-abu", "Kuning"], 1),
            ("Planet terbesar di tata surya?", ["Mars", "Bumi", "Jupiter", "Saturnus"], 2)
        ],
        "Challenge C": [
            ("Hewan tercepat di dunia?", ["Cheetah", "Elang", "Ikan Todak", "Kuda"], 0),
            ("Berapa gigi manusia dewasa?", ["28", "30", "32", "34"], 2)
        ]
    ]
    
    var questions: [(question: String, answers: [String], correctAnswer: Int)] {
        challengeQuestions[challenge] ?? []
    }
    
    var body: some View {
        VStack {
            if showResult {
                Text("Quiz Completed!")
                    .font(.title)
                    .padding()
                Text("Your Score: \(score) / \(questions.count)")
                    .font(.headline)
                    .padding()
                
                Button("Back to Challenges") {
                    completedChallenges += 1
                }
                .padding()
                .background(Color.blue.opacity(0.7))
                .cornerRadius(5)
                .foregroundColor(.white)
            } else if questionIndex < questions.count {
                Text(questions[questionIndex].question)
                    .font(.title)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<4, id: \ .self) { index in
                        Button(action: {
                            selectedAnswer = index
                        }) {
                            Text(questions[questionIndex].answers[index])
                                .frame(width: 150, height: 100)
                                .background(selectedAnswer == index ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedAnswer == index ? Color.blue : Color.clear, lineWidth: 3)
                                )
                        }
                    }
                }
                .padding()
                
                Button(action: {
                    if selectedAnswer == questions[questionIndex].correctAnswer {
                        score += 1
                    }
                    
                    if questionIndex < questions.count - 1 {
                        questionIndex += 1
                        selectedAnswer = nil
                    } else {
                        showResult = true
                    }
                }) {
                    Text(questionIndex == questions.count - 1 ? "Submit" : "Next")
                        .padding()
                        .background(selectedAnswer != nil ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                }
                .disabled(selectedAnswer == nil)
                .padding()
            }
        }
    }
}


struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
