import SwiftUI

struct ContentView: View {
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            ChallengeView()
                .tabItem {
                    Label("Challenge", systemImage: "star.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
