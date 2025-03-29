//
//  BottomSheet.swift
//  TemuTempat
//
//  Created by Akbar Febry on 26/03/25.
//

import SwiftUI

struct BottomSheet: View {
    var places: [Places]
    @State private var selectedPlace: Places? // Track the selected place
    @State private var dragOffset: CGFloat = 0
    @State private var heightState: SheetHeight = .mid // Changed default to mid
    
    // Threshold for drag gesture to change states
    private let dragThreshold: CGFloat = 50
    
    enum SheetHeight {
        case low, mid, full
        
        var height: CGFloat {
            switch self {
            case .low: return UIScreen.main.bounds.height * 0.45
            case .mid: return UIScreen.main.bounds.height * 0.5
            case .full: return UIScreen.main.bounds.height * 0.9
            }
        }
        
        // Get the next height state when dragging up
        func next() -> SheetHeight {
            switch self {
            case .low: return .mid
            case .mid: return .full
            case .full: return .full
            }
        }
        
        // Get the previous height state when dragging down
        func previous() -> SheetHeight {
            switch self {
            case .low: return .low
            case .mid: return .low
            case .full: return .mid
            }
        }
    }
    
    // Calculate current height based on state and drag offset
    private var currentHeight: CGFloat {
        let baseHeight = heightState.height
        return max(SheetHeight.low.height, min(SheetHeight.full.height, baseHeight - dragOffset))
    }
    
    // Calculate Y offset based on current height
    private var yOffset: CGFloat {
        UIScreen.main.bounds.height - currentHeight
    }
    
    var body: some View {
        VStack {
            // Drag indicator
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 10)
            
            HStack {
                Text("Explore")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                if selectedPlace != nil {
                    Spacer()
                    Button(action: {
                        self.selectedPlace = nil // Deselect to return to list
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.title2)
                            .padding(.trailing, 20)
                    }
                }
            }
            
            ScrollView {
                if let selectedPlace = selectedPlace {
                    PlaceDetails(selectedPlace: selectedPlace)
                } else {
                    // Show list of cards when no place is selected
                    VStack {
                        ForEach(places) { place in
                            PlacesCard(places: place)
                                .onTapGesture {
                                    selectedPlace = place // Select the tapped place
                                    // Expand the sheet when selecting a place
                                    heightState = .full
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 30)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(height: currentHeight)
        .offset(y: yOffset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    // Update drag offset as user drags
                    dragOffset = max(0, min(heightState.height - SheetHeight.low.height, gesture.translation.height))
                }
                .onEnded { gesture in
                    // Determine if we should change states based on drag direction and distance
                    if gesture.translation.height < -dragThreshold {
                        // Dragged up significantly, go to next height state
                        heightState = heightState.next()
                    } else if gesture.translation.height > dragThreshold {
                        // Dragged down significantly, go to previous height state
                        heightState = heightState.previous()
                    }
                    // Reset drag offset
                    dragOffset = 0
                }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: heightState)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: dragOffset)
        .animation(.easeInOut, value: selectedPlace) // Animate the switch
    }
}

#Preview {
    let modelData = ModelData()
    BottomSheet(places: modelData.places)
        .environment(modelData)
}
