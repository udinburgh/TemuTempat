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
    Places(placeName: "Cinema XXI", imageName:"cinema", placeDescription:"Cinema XXI, destinasi utama menonton film Anda. Nikmati pengalaman menonton terbaik dengan teknologi terbaru.", tags:"Watching"),
    Places(placeName: "Chatime", imageName:"chatime", placeDescription:"Chatime merupakan penyedia minuman brewed tea yang menghadirkan lebih dari 50 varian rasa.", tags:"Drinking"),
    Places(placeName: "Chateraise", imageName:"chateraise", placeDescription:"Chateraise adalah toko kue dari Jepang yang menjual berbagai macam kue.", tags:"Dessert"),
    Places(placeName: "D' COST", imageName:"dcost", placeDescription:"D'Cost adalah jaringan restoran seafood terbesar di Indonesia.", tags:"Eating"),
    Places(placeName: "AuntieAnne's", imageName:"auntieannes", placeDescription:"Auntie Anne's adalah jaringan waralaba toko kudapan pretzel dari Amerika Serikat.", tags:"Eating")
]

struct BottomSheet: View {
    var places: [Places]
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 10)
            
            ScrollView {
                VStack {
                    ForEach(places, id: \.placeName) { place in
                        PlacesCard(places: place)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 30)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
        .offset(y: UIScreen.main.bounds.height * 0.45)
    }
}

#Preview {
    ContentView()
}
