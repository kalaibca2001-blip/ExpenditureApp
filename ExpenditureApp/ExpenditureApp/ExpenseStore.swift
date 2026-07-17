//
//  ExpenseStore.swift
//  ExpenditureApp
//
//  Created by VC on 15/07/26.
//

import SwiftUI
import Combine
class ExpenseStore: ObservableObject {

    @Published var expenses: [Expense] = []

}


