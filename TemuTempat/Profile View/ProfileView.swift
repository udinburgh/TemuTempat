import SwiftUI

struct ProfileView: View {
    @State var selectedFilter: ProfileFilter = .Achievements
    @State var userName: String = "Fulan"
    @State private var isEditing: Bool = false
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0 
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .font(.system(size: 75))
                .padding(30)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Color.black, lineWidth: 1)
                        .shadow(radius: 5)
                }
            
            HStack {
                if isEditing {
                    TextField("Enter name", text: $userName, onCommit: {
                        isEditing = false
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                } else {
                    Text(userName)
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                }
                
                Button(action: {
                    isEditing.toggle()
                }) {
                    Image(systemName: "square.and.pencil")
                }
            }
            .padding()
            
            HStack {
                ForEach(ProfileFilter.allCases, id: \.rawValue) { item in
                    VStack {
                        Text(item.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == item ? .semibold : .regular)
                            .foregroundColor(selectedFilter == item ? Color.primary : .gray)
                        
                        Capsule()
                            .foregroundColor(selectedFilter == item ? Color.primary : Color.clear)
                            .frame(height: 3)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.selectedFilter = item
                        }
                    }
                }
            }
            .padding(.top)
            
            VStack {
                switch selectedFilter {
                case .Achievements:
                    AchievementView()
                case .History:
                    HistoryView()
                case .Favorites:
                    FavoriteView()
                }
            }
            
            Spacer()
        }
    }
}


#Preview {
    ProfileView()
}
