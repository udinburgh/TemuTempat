import SwiftUI
import MapKit
import SwiftData

struct MapView: View {
    @Query(sort: \Building.id, order: .forward) var buildings: [Building]
    @Query var places: [Place]
    @Environment(\.modelContext) private var context
    
    @State private var position = MapCameraPosition.region(initialRegion)
    @State private var selectedBuilding: Building?
    @State private var searchTerm: String = ""
    @State private var selectedTags: Set<String> = []
    @FocusState private var isSearchFocused: Bool
    @State private var selectedAnnotationTitle: String? = nil

    


    private static let initialRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.302370, longitude: 106.652059),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.006)
    )

    private func centerMap() {
        position = .region(Self.initialRegion)
    }

    var isSearching: Bool {
        isSearchFocused || !searchTerm.isEmpty
    }
    
    var bottomSheetTitle: String {
        if let selectedBuilding = selectedBuilding {
            return selectedBuilding.name
        } else if let titleFromAnnotation = selectedAnnotationTitle {
            return titleFromAnnotation
        } else {
            return "Explore"
        }
    }


    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(buildings) { building in
                    if let coord = building.locationCoordinate {
                        Annotation(building.name, coordinate: coord) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                                .onTapGesture {
                                    isSearchFocused = false
                                    
                                    // Ambil tag pertama
                                    if let tag = building.tags.first {
                                        selectedTags = [tag]
                                        selectedAnnotationTitle = building.name
                                        selectedBuilding = nil // Jangan buka detail langsung
                                    }

                                }

                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            if isSearching {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .blur(radius: 10)
                    .transition(.opacity)
                    .zIndex(0.5)
            }
            
            BottomSheet(
                buildings: buildings,
                isSearching: .constant(isSearching),
                searchTerm: $searchTerm,
                selectedBuilding: $selectedBuilding,
                selectedTags: $selectedTags,
                selectedAnnotationTitle: $selectedAnnotationTitle, // ⬅️ Tambahkan ini
                title: bottomSheetTitle
            )


            .transition(.move(edge: .bottom))
            .zIndex(1)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        centerMap()
                    }) {
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
                }
            }
            .zIndex(1.5)

            VStack {
                SearchBar(
                    searchTerm: $searchTerm,
                    isFocused: $isSearchFocused,
                    selectedTags: $selectedTags,
                    buildings: buildings
                )
                .padding(.top, 10)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .zIndex(2)
        }
        .onChange(of: searchTerm) { _, newValue in
            if !newValue.isEmpty {
                selectedBuilding = nil
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isSearching)
    }
}

#Preview {
    MapView()
        .modelContainer(for: Building.self)
}
