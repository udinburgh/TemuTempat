import SwiftUI
import MapKit

struct HomeView: View {
    @Binding var searchTerm: String
    var places: [Places]
    
    let cameraPosition: MapCameraPosition = .region(.init(
        center: .init(latitude: -6.301387, longitude: 106.652034),
        latitudinalMeters: 500,
        longitudinalMeters: 500
    ))
    
    var isSearching: Bool {
        !searchTerm.isEmpty
    }
    
    var body: some View {
        ZStack {
            Map(initialPosition: cameraPosition)
                .blur(radius: isSearching ? 10 : 0)
                .transaction { $0.animation = .easeInOut }

            VStack {
                HStack {
                    TextField("Search here...", text: $searchTerm)
                        .padding(.leading, 30)
                        .padding(10)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                        )
                        .shadow(radius: 3)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Spacer()
            }
            
            // Kirimkan isSearching ke BottomSheet
            BottomSheet(places: places, isSearching: isSearching)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var searchTerm = ""
        let samplePlaces: [Places] = []
        
        var body: some View {
            HomeView(searchTerm: $searchTerm, places: samplePlaces)
        }
    }
    return PreviewWrapper()
}
