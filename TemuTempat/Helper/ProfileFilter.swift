//
//  ProfileFilter.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import Foundation
    
enum ProfileFilter: Int, CaseIterable {
    case Achievements
    case History
    case Favorites
    
    var title: String {
        switch self {
        case .Achievements:
            return "Achievements"
        case .History:
            return "History"
        case .Favorites:
            return "Favorites"
        }
    }
}

