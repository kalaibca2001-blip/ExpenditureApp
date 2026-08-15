//
//  ContentView.swift
//  ExpenditureApp
//
//  Created by VC on 03/07/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn = false
    
    var body: some View {
        
        Group {
            
            if isLoggedIn {
                HomeViewNew()
            } else {
                LoginView()
            }
        }
        .onAppear {
            checkLoginStatus()
        }
    }
    
    private func checkLoginStatus() {
        
        let status = KeychainManager.shared.read(
            forKey: "isLoggedIn"
        )
        
        isLoggedIn = status == "true"
    }
}

#Preview {
    ContentView()
}
