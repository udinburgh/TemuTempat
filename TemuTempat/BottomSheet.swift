import SwiftUI

struct BottomSheet: View {
    var places: [Places]
    var isSearching: Bool
    
    @State private var sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.25 // Default ke 1/4 layar
    
    var minHeight: CGFloat { UIScreen.main.bounds.height * 0.25 } // 1/4 layar
    var midHeight: CGFloat { UIScreen.main.bounds.height * 0.5 }  // 1/2 layar
    var maxHeight: CGFloat { UIScreen.main.bounds.height * 0.75 } // 3/4 layar
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top, 20)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newHeight = sheetHeight - value.translation.height
                            if newHeight >= minHeight && newHeight <= maxHeight {
                                sheetHeight = newHeight
                            }
                        }
                        .onEnded { _ in
                            withAnimation {
                                if sheetHeight > (midHeight + maxHeight) / 2 {
                                    sheetHeight = maxHeight // Geser ke 3/4 layar
                                } else if sheetHeight > (minHeight + midHeight) / 2 {
                                    sheetHeight = midHeight // Geser ke 1/2 layar
                                } else {
                                    sheetHeight = minHeight // Geser ke 1/4 layar
                                }
                            }
                        }
                )
            
            if !places.isEmpty {
                ScrollView {
                    VStack {
                        ForEach(places, id: \.placeName) { place in
                            PlacesCard(places: place)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 30)
            } else {
                VStack {
                    Text("No places available")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
                .padding(.bottom, 30)
                .frame(maxHeight: .infinity)
            }
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxHeight: sheetHeight)
        .offset(y: UIScreen.main.bounds.height * 0.50 - sheetHeight / 2)
        .onChange(of: isSearching) { oldValue, newValue in
            withAnimation {
                sheetHeight = newValue ? maxHeight : minHeight
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        let samplePlaces: [Places] = []
        @State private var isSearching = false
        
        var body: some View {
            BottomSheet(places: samplePlaces, isSearching: isSearching)
        }
    }
    return PreviewWrapper()
}
