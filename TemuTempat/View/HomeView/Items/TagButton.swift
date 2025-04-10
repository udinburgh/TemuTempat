import SwiftUI

struct TagButton: View {
    var tag: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(tag)
                .font(.system(size: 14))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(1000.0))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(15)
        }
    }
}
#Preview {
    TagButton(
        tag: "Sample Tag",
        isSelected: false,
        action: { print("Tag tapped") }
    )
    .padding()
}
