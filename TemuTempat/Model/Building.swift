//
//  Places.swift
//  
//
//  Created by Akbar Febry on 26/03/25.
//

import Foundation
import SwiftUI
import SwiftData
import CoreLocation

@Model
class Building: Identifiable {
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
    
    // Make coordinates optional
    var coordinates: Coordinates?
    
    // Handle optional coordinates in the computed property
    var locationCoordinate: CLLocationCoordinate2D? {
        guard let coords = coordinates else { return nil }
        return CLLocationCoordinate2D(
            latitude: coords.latitude,
            longitude: coords.longitude
        )
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var operationalHours: String?
    
    // Update initializer to accept optional coordinates
    init(id: Int, name: String, desc: String, isFavorite: Bool, isFeatured: Bool, address: String, tags: [String], imageName: String, coordinates: Coordinates? = nil, operationalHours: String? = nil) {
        self.id = id
        self.name = name
        self.desc = desc
        self.isFavorite = isFavorite
        self.isFeatured = isFeatured
        self.address = address
        self.tags = tags
        self.imageName = imageName
        self.coordinates = coordinates
        self.operationalHours = operationalHours
    }
}
