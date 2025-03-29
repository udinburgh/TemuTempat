//
//  ContentView.swift
//  Coba Coba
//
//  Created by Cynthia Shabrina on 19/03/25.
//

import SwiftUI
import MapKit

struct Places {
    let placeName: String
    let imageName: String
    let placeDescription: String
    let tags: String
}

struct ContentView: View {
    @AppStorage("completedChallenges") private var completedChallenges: Int = 0
    @State private var searchTerm = ""
    
    var filteredPlaces: [Places] {
        if searchTerm.isEmpty {
            return places
        } else {
            return places.filter { $0.placeName.localizedCaseInsensitiveContains(searchTerm) }
        }
    }

    var body: some View {
        TabView {
            HomeView(searchTerm: $searchTerm, places: filteredPlaces)
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

let places: [Places] = [
    Places(placeName: "Cinema XXI", imageName:"CinemaXX1", placeDescription:"Cinema XXI, destinasi utama menonton film Anda. Nikmati pengalaman menonton terbaik dengan teknologi terbaru.", tags:"Watching"),
    Places(placeName: "Chatime", imageName:"Chatime", placeDescription:"Chatime merupakan penyedia minuman brewed tea yang menghadirkan lebih dari 50 varian rasa.", tags:"Drinking"),
    Places(placeName: "Chateraise", imageName:"CinemaXX1", placeDescription:"Chateraise adalah toko kue dari Jepang yang menjual berbagai macam kue.", tags:"Dessert"),
    Places(placeName: "D' COST", imageName:"CinemaXX1", placeDescription:"D'Cost adalah jaringan restoran seafood terbesar di Indonesia.", tags:"Eating"),
    Places(placeName: "AuntieAnne's", imageName:"CinemaXX1", placeDescription:"Auntie Anne's adalah jaringan waralaba toko kudapan pretzel dari Amerika Serikat.", tags:"Eating"),
    Places(placeName: "Starbucks", imageName: "StarbucksLogo", placeDescription: "Starbucks adalah jaringan kedai kopi terbesar di dunia yang berasal dari Amerika Serikat.", tags: "Cafe"),
    Places(placeName: "Burger King", imageName: "BurgerKingLogo", placeDescription: "Burger King adalah jaringan restoran cepat saji yang terkenal dengan burger Whopper-nya.", tags: "Fast Food"),
    Places(placeName: "J.CO Donuts", imageName: "JCOLogo", placeDescription: "J.CO Donuts adalah jaringan gerai donat dan kopi asal Indonesia.", tags: "Cafe"),
    Places(placeName: "KFC", imageName: "KFCLogo", placeDescription: "KFC adalah restoran cepat saji terkenal yang menyajikan ayam goreng dengan resep rahasia.", tags: "Fast Food"),
    Places(placeName: "Chatime", imageName: "ChatimeLogo", placeDescription: "Chatime adalah jaringan minuman bubble tea asal Taiwan yang populer di seluruh dunia.", tags: "Beverage")

]
#Preview {
    ContentView()
}
