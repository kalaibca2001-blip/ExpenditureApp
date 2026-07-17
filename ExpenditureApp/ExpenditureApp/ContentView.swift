//
//  ContentView.swift
//  ExpenditureApp
//
//  Created by VC on 03/07/26.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        NavigationStack {
            HomeView(store: ExpenseStore())
        }
    }
}

#Preview {
    ContentView()
}
