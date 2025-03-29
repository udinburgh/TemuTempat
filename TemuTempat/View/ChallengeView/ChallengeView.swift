//
//  ChallengeView.swift
//  TemuTempat
//
//  Created by Akbar Febry on 29/03/25.
//

import SwiftUI

struct ChallengeView: View {
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0
    @AppStorage("completedChallengesList") private var completedChallengesList: String = ""
    
    let challenges = ["Challenge A", "Challenge B", "Challenge C", "Challenge D", "Challenge E", "Challenge F", "Challenge G", "Challenge H", "Challenge I"]
    
    var completedChallengesSet: Set<String> {
        Set(completedChallengesList.components(separatedBy: ",").filter { !$0.isEmpty })
    }
    
    func markChallengeCompleted(_ challenge: String) {
        if !completedChallengesSet.contains(challenge) {
            completedChallengesList += completedChallengesList.isEmpty ? challenge : ",\(challenge)"
            completedChallenges += 1
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Challenge")
                        .font(.largeTitle)
                        .padding()
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(challenges, id: \.self) { challenge in
                            VStack {
                                Text(challenge)
                                    .font(.headline)
                                    .padding(.top)
                                
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                    .font(.caption)
                                    .padding()
                                
                                NavigationLink(destination: QuizView(challenge: challenge, markChallengeCompleted: markChallengeCompleted)) {
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
}


struct QuizView: View {
    let challenge: String
    @Environment(\.presentationMode) var presentationMode
    var markChallengeCompleted: (String) -> Void

    @State private var selectedAnswer: Int? = nil
    @State private var questionIndex: Int = 0
    @State private var score: Int = 0
    @State private var showResult: Bool = false
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0
    @AppStorage("completedChallengesList") private var completedChallengesList: String = ""
    
    let challengeQuestions: [String: [(question: String, answers: [String], correctAnswer: Int)]] = [
            "Challenge A": [
                ("Kucing termasuk hewan apa?", ["Mamalia", "Reptil", "Amfibi", "Ikan"], 0),
                ("Berapa kaki laba-laba?", ["4", "6", "8", "10"], 2),
                ("Hewan apa yang bisa terbang?", ["Kucing", "Burung", "Ikan", "Ular"], 1),
                ("Berapa jumlah kaki semut?", ["2", "4", "6", "8"], 2),
                ("Dimana ikan hidup?", ["Darat", "Laut", "Langit", "Gunung"], 1),
                ("Apa hewan terbesar di dunia?", ["Gajah", "Paus Biru", "Jerapah", "Hiu"], 1)
            ],
            "Challenge B": [
                ("Apa warna khas panda?", ["Coklat", "Hitam Putih", "Abu-abu", "Kuning"], 1),
                ("Planet terbesar di tata surya?", ["Mars", "Bumi", "Jupiter", "Saturnus"], 2),
                ("Berapa jumlah kaki laba-laba?", ["6", "8", "10", "12"], 1),
                ("Bintang terdekat dengan bumi?", ["Matahari", "Sirius", "Betelgeuse", "Proxima Centauri"], 0),
                ("Apa unsur utama dalam air?", ["Oksigen", "Hidrogen", "H2O", "Karbon"], 2),
                ("Gunung tertinggi di dunia?", ["Everest", "Kilimanjaro", "Alpen", "Himalaya"], 0)
            ],
            "Challenge C": [
                ("Kucing termasuk hewan apa?", ["Mamalia", "Reptil", "Amfibi", "Ikan"], 0),
                ("Berapa kaki laba-laba?", ["4", "6", "8", "10"], 2),
                ("Hewan apa yang bisa terbang?", ["Kucing", "Burung", "Ikan", "Ular"], 1),
                ("Berapa jumlah kaki semut?", ["2", "4", "6", "8"], 2),
                ("Dimana ikan hidup?", ["Darat", "Laut", "Langit", "Gunung"], 1),
                ("Apa hewan terbesar di dunia?", ["Gajah", "Paus Biru", "Jerapah", "Hiu"], 1)
            ],
            "Challenge D": [
                ("Apa warna khas panda?", ["Coklat", "Hitam Putih", "Abu-abu", "Kuning"], 1),
                ("Planet terbesar di tata surya?", ["Mars", "Bumi", "Jupiter", "Saturnus"], 2),
                ("Berapa jumlah kaki laba-laba?", ["6", "8", "10", "12"], 1),
                ("Bintang terdekat dengan bumi?", ["Matahari", "Sirius", "Betelgeuse", "Proxima Centauri"], 0),
                ("Apa unsur utama dalam air?", ["Oksigen", "Hidrogen", "H2O", "Karbon"], 2),
                ("Gunung tertinggi di dunia?", ["Everest", "Kilimanjaro", "Alpen", "Himalaya"], 0)
            ],
            "Challenge E": [
                ("Kucing termasuk hewan apa?", ["Mamalia", "Reptil", "Amfibi", "Ikan"], 0),
                ("Berapa kaki laba-laba?", ["4", "6", "8", "10"], 2),
                ("Hewan apa yang bisa terbang?", ["Kucing", "Burung", "Ikan", "Ular"], 1),
                ("Berapa jumlah kaki semut?", ["2", "4", "6", "8"], 2),
                ("Dimana ikan hidup?", ["Darat", "Laut", "Langit", "Gunung"], 1),
                ("Apa hewan terbesar di dunia?", ["Gajah", "Paus Biru", "Jerapah", "Hiu"], 1)
            ],
            "Challenge F": [
                ("Apa warna khas panda?", ["Coklat", "Hitam Putih", "Abu-abu", "Kuning"], 1),
                ("Planet terbesar di tata surya?", ["Mars", "Bumi", "Jupiter", "Saturnus"], 2),
                ("Berapa jumlah kaki laba-laba?", ["6", "8", "10", "12"], 1),
                ("Bintang terdekat dengan bumi?", ["Matahari", "Sirius", "Betelgeuse", "Proxima Centauri"], 0),
                ("Apa unsur utama dalam air?", ["Oksigen", "Hidrogen", "H2O", "Karbon"], 2),
                ("Gunung tertinggi di dunia?", ["Everest", "Kilimanjaro", "Alpen", "Himalaya"], 0)
            ],
            "Challenge G": [
                ("Kucing termasuk hewan apa?", ["Mamalia", "Reptil", "Amfibi", "Ikan"], 0),
                ("Berapa kaki laba-laba?", ["4", "6", "8", "10"], 2),
                ("Hewan apa yang bisa terbang?", ["Kucing", "Burung", "Ikan", "Ular"], 1),
                ("Berapa jumlah kaki semut?", ["2", "4", "6", "8"], 2),
                ("Dimana ikan hidup?", ["Darat", "Laut", "Langit", "Gunung"], 1),
                ("Apa hewan terbesar di dunia?", ["Gajah", "Paus Biru", "Jerapah", "Hiu"], 1)
            ],
            "Challenge H": [
                ("Apa warna khas panda?", ["Coklat", "Hitam Putih", "Abu-abu", "Kuning"], 1),
                ("Planet terbesar di tata surya?", ["Mars", "Bumi", "Jupiter", "Saturnus"], 2),
                ("Berapa jumlah kaki laba-laba?", ["6", "8", "10", "12"], 1),
                ("Bintang terdekat dengan bumi?", ["Matahari", "Sirius", "Betelgeuse", "Proxima Centauri"], 0),
                ("Apa unsur utama dalam air?", ["Oksigen", "Hidrogen", "H2O", "Karbon"], 2),
                ("Gunung tertinggi di dunia?", ["Everest", "Kilimanjaro", "Alpen", "Himalaya"], 0)
            ],
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
                    if Double(score) / Double(questions.count) >= 0.5 {
                        markChallengeCompleted(challenge)
                    }
                    presentationMode.wrappedValue.dismiss()
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
                    ForEach(0..<4, id: \.self) { index in
                        Button(action: {
                            selectedAnswer = index
                        }) {
                            Text(questions[questionIndex].answers[index])
                                .frame(width: 150, height: 50)
                                .background(selectedAnswer == index ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2))
                                .cornerRadius(10)
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

#Preview {
    ChallengeView()
}
