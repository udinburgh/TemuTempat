//////
//////  SearchBarView.swift
//////  TemuTempat
//////
//////  Created by Akbar Febry on 27/03/25.
//////
import SwiftUI

struct SearchBar: View {
    @Binding var searchTerm: String
    @FocusState.Binding var isFocused: Bool
    @Binding var selectedTags: Set<String>
    var buildings: [Building]
    

    private var allTags: [String] {
        var seen = Set<String>()
        var orderedTags: [String] = []

        for building in buildings {
            for tag in building.tags {
                let shouldHide = hiddenKeywords.contains { keyword in
                    tag.localizedCaseInsensitiveContains(keyword)
                }

                if !seen.contains(tag) && !shouldHide {
                    seen.insert(tag)
                    orderedTags.append(tag)
                }
            }
        }

        return orderedTags
    }

    let hiddenKeywords = ["GOP", "the breeze", "ranch market", "graha unilever", "front gate"] // Tambahkan kata lain jika perlu

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 20)

                TextField("Search here...", text: $searchTerm)
                    .focused($isFocused)
                    .padding(10)
                    .submitLabel(.search)
                    .autocorrectionDisabled()

                if isFocused || !searchTerm.isEmpty {
                    Button {
                        searchTerm = ""
                        dismissKeyboard()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 20)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .shadow(radius: 5)
            .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button(action: {
                        selectedTags.removeAll()
                    }) {
                        Text("All")
                            .padding(8)
                            .padding(.horizontal, 10)
                            .background(selectedTags.isEmpty ? Color.blue : Color.gray.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .font(.caption)
                    }

                    ForEach(allTags, id: \.self) { tag in
                        Button(action: {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }) {
                            Text(tag)
                                .padding(8)
                                .background(selectedTags.contains(tag) ? Color.blue : Color.gray.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.top, 5)
            .padding(.bottom, 5)
        }
        .ignoresSafeArea(.keyboard)
        .frame(maxHeight: .infinity, alignment: .top)
        .zIndex(2)
    }
}
