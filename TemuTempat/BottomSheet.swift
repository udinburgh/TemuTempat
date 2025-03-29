import SwiftUI

struct BottomSheet: View {
    var places: [Places]
    @State private var sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    @State private var dragOffset: CGFloat = 0
    
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
                            if newHeight >= UIScreen.main.bounds.height * 0.5 && newHeight <= UIScreen.main.bounds.height * 0.75 {
                                sheetHeight = newHeight
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                if sheetHeight > UIScreen.main.bounds.height * 0.625 {
                                    sheetHeight = UIScreen.main.bounds.height * 0.75
                                } else {
                                    sheetHeight = UIScreen.main.bounds.height * 0.5
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
    }
}

#Preview {
    BottomSheet(places: places)
}
