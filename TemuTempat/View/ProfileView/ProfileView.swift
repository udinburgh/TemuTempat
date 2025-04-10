//
//  SimplifiedProfileView.swift
//  TemuTempat
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    // State variables
    @State var selectedFilter: ProfileFilter = .Achievements
    @State var userName: String = "Fulan"
    @State private var isEditing: Bool = false
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0
    @AppStorage("profileImagePath") private var profileImagePath: String = ""
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    @State private var uiImage: UIImage? = nil
    @State private var showChangeButton: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Profile header
            VStack(spacing: 20) {
                // Profile image
                ProfileImageView(
                    profileImage: $profileImage,
                    showChangeButton: $showChangeButton,
                    selectedItem: $selectedItem
                )
                
                // Name section
                ProfileNameView(
                    userName: $userName,
                    isEditing: $isEditing
                )
                
                // Stats section
                let medals = ProfileHelpers.calculateMedals(completedChallenges: completedChallenges)
                ProfileStatsView(
                    completedChallenges: completedChallenges,
                    medals: medals
                )
            }
            .padding(.top, 20)
            .padding(.bottom, 10)
            
            // Filter tabs
            ProfileTabsView(selectedFilter: $selectedFilter)
            
            // Content based on selected filter
            if selectedFilter == .Achievements {
                AchievementView()
            } else {
                FavoriteView()
            }
            
            Spacer()
        }
        .onAppear {
            loadProfileImage()
        }
        .onChange(of: selectedItem) { processSelectedItem() }
    }
    
    // Load profile image
    private func loadProfileImage() {
        if let uiImg = ProfileHelpers.loadImageFromFileSystem(path: profileImagePath) {
            self.uiImage = uiImg
            self.profileImage = Image(uiImage: uiImg)
        }
    }
    
    // Process selected photo
    private func processSelectedItem() {
        guard let newItem = selectedItem else { return }
        Task {
            do {
                if let data = try await newItem.loadTransferable(type: Data.self),
                   let uiImg = UIImage(data: data) {
                    await MainActor.run {
                        self.uiImage = uiImg
                        self.profileImage = Image(uiImage: uiImg)
                        ProfileHelpers.saveImageToFileSystem(uiImg, path: &profileImagePath)
                        withAnimation {
                            showChangeButton = false
                        }
                    }
                }
            } catch {
                print("Failed to load image: \(error)")
            }
        }
    }
}

#Preview {
    ProfileView()
}
