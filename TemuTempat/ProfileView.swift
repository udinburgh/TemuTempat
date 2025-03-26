//
//  ProfileView.swift
//  TemuTempat
//
//  Created by Hafizhuddin Hanif on 26/03/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person")
                    .font(.system(size: 75))
                    .padding(30)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(Color.black, lineWidth: 1)
                            .shadow(radius: 5)
                        
                    }
                
                Text("Profile")
                    .font(.largeTitle)
                Text("Level xxx")
                
                HStack {
                    ForEach(ProfileFilter.allCases, id: \.rawValue){
                        item in
                    }
                }
//                coba
                Spacer()

            }            
        }
    }
}


#Preview {
    ProfileView()
}
