import SwiftUI

struct BottomSheet: View {
    var buildings: [Building]
    @Binding var isSearching: Bool
    @Binding var searchTerm: String
    @Binding var selectedBuilding: Building?
    @Binding var selectedTags: Set<String>
    @Binding var selectedAnnotationTitle: String?
    let title: String
    private let primaryBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    private let lightBlue = Color(red: 0.9, green: 0.95, blue: 1.0)
    
    
    @State private var sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.3
    
    var minHeight: CGFloat { UIScreen.main.bounds.height * 0.3 }
    var midHeight: CGFloat { UIScreen.main.bounds.height * 0.55 }
    var maxHeight: CGFloat { UIScreen.main.bounds.height * 0.75 }
    
    private var filteredBuildings: [Building] {
        buildings.filter { building in
            let lowercasedName = building.name.lowercased()
            let isHidden =
            lowercasedName.contains("green office park") ||
            lowercasedName.contains("the breeze") ||
            lowercasedName.contains("graha unilever") ||
            lowercasedName.contains("gate") ||
            lowercasedName.contains("car") ||
            lowercasedName.contains("ranch market") ||
            lowercasedName.contains("parking") ||
            lowercasedName.contains("marketing office")
            let matchesSearch = searchTerm.isEmpty || lowercasedName.contains(searchTerm.lowercased())
            let matchesTags = selectedTags.isEmpty || selectedTags.allSatisfy { tag in
                building.tags.contains(tag)
            }
            return !isHidden && matchesSearch && matchesTags
        }
    }
    
    private func expandToMaxHeight() {
        withAnimation {
            sheetHeight = maxHeight
        }
    }
    
    @ViewBuilder
    private func BuildingListView() -> some View {
        VStack(spacing: 0) {
            ForEach(filteredBuildings) { building in
                BuildingCard(building: building, primaryBlue: primaryBlue, lightBlue: lightBlue)
                    .onTapGesture {
                        withAnimation {
                            selectedBuilding = building
                            expandToMaxHeight()
                        }
                    }
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
    }

    @ViewBuilder
    private func ContentScrollView() -> some View {
        ScrollView {
            if let selectedBuilding = selectedBuilding {
                BuildingDetails(selectedBuilding: selectedBuilding)
                    .padding(.horizontal)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else if filteredBuildings.isEmpty {
                Text("No places available")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top, 40)
            } else {
                VStack(spacing: 0) {
                    ForEach(filteredBuildings) { building in
                        BuildingCard(building: building, primaryBlue: primaryBlue, lightBlue: lightBlue)
                            .onTapGesture {
                                withAnimation {
                                    selectedBuilding = building
                                    expandToMaxHeight()
                                }
                            }
                            .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 80)
    }

    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 10)
            
            HStack {
                if title == "Explore" {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                } else {
                    Spacer()
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                }

                if selectedBuilding != nil || (selectedAnnotationTitle != nil && selectedBuilding == nil) {
                    Button {
                        selectedBuilding = nil
                        selectedTags.removeAll()
                        searchTerm = ""
                        selectedAnnotationTitle = nil
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
            }

            .padding(.horizontal)
            .padding(.top, 10)
            
            
            Divider().padding(.vertical)
            
            ContentScrollView()

        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxHeight: sheetHeight)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let newHeight = sheetHeight - value.translation.height
                    if newHeight >= minHeight && newHeight <= maxHeight {
                        sheetHeight = newHeight
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        if sheetHeight > (midHeight + maxHeight) / 2 {
                            sheetHeight = maxHeight
                        } else if sheetHeight > (minHeight + midHeight) / 2 {
                            sheetHeight = midHeight
                        } else {
                            sheetHeight = minHeight
                        }
                    }
                }
        )
        .offset(y: UIScreen.main.bounds.height * 0.50 - sheetHeight / 2)
        .onChange(of: isSearching) { _, newValue in
            withAnimation {
                sheetHeight = newValue ? maxHeight : minHeight
            }
        }
        .onChange(of: selectedTags) { _, _ in
            if !selectedTags.isEmpty {
                expandToMaxHeight()
            }
        }
        .animation(.easeInOut, value: selectedBuilding)
    }
}
