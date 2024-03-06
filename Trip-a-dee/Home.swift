//
//  Home.swift
//  Trip-a-dee
//
//  Created by Zach Pregl on 6/3/2024.
//

import SwiftUI

struct Home: View {
    @State private var username: String = ""
    var body: some View {
        
        TextField("Username", text: $username)
            .padding()
            .frame(height: 50)
            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.75)
            .background(.ultraThinMaterial)
            
            .cornerRadius(14)
    }
}

#Preview {
    Home()
}
