//
//  Place.swift
//  TemuTempat
//
//  Created by Akbar Febry on 02/04/25.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Place {
    var id: Int
    var name: String
    var desc: String
    var isFavorite: Bool
    var isFeatured: Bool
    var address: String
    var tags: [String]

    private var imageName: String
    
    var image: Image {
        Image(imageName)
    }
    
    var operationalHours: String
        
    init(id: Int, name: String, desc: String, isFavorite: Bool, isFeatured: Bool, address: String, tags: [String], imageName: String, operationalHours: String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.isFavorite = isFavorite
        self.isFeatured = isFeatured
        self.address = address
        self.tags = tags
        self.imageName = imageName
        self.operationalHours = operationalHours
    }
}
