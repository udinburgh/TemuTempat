//
//  Places.swift
//  
//
//  Created by Akbar Febry on 26/03/25.
//

import Foundation
import SwiftUI
import CoreLocation

struct Places: Hashable, Codable, Identifiable {      // add Identifiable so items dont need to be declared the id params
    var id: Int
    var name: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    var address: String
    var tags: [String]
    
    private var imageName: String
    
    var image: Image {
        Image(imageName)
    }
    
    var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
