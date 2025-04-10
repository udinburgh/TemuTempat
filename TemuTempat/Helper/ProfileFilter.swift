//
//  ProfileFilter.swift
//  TemuTempat
//
//  Created by Akbar Febry on 09/04/25.
//

import SwiftUI

// Profile filter enum
enum ProfileFilter: String, CaseIterable {
    case Achievements
    case Favorites
    
    var title: String {
        return self.rawValue
    }
}

// Helper functions for profile
class ProfileHelpers {
    // Calculate medals based on completed challenges
    static func calculateMedals(completedChallenges: Int) -> Int {
        var medals = 0
        if completedChallenges >= 2 { medals += 1 }
        if completedChallenges >= 5 { medals += 1 }
        if completedChallenges >= 10 { medals += 1 }
        return medals
    }
    
    // Get documents directory
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // Save image to file system
    static func saveImageToFileSystem(_ image: UIImage, path: inout String) {
        let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: filename)
            path = filename.path
        }
    }
    
    // Load image from file system
    static func loadImageFromFileSystem(path: String) -> UIImage? {
        let url = URL(fileURLWithPath: path)
        if FileManager.default.fileExists(atPath: path),
           let data = try? Data(contentsOf: url),
           let uiImg = UIImage(data: data) {
            return uiImg
        }
        return nil
    }
}
