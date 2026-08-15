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
        .onReceive(
            NotificationCenter.default.publisher(
                for: Notification.Name("userDidLogin")
            )
        ) { _ in
            
            isLoggedIn = true
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: Notification.Name("userDidLogout")
            )
        ) { _ in
            
            isLoggedIn = false
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
