//
//  ExpenseIncomeRecord.swift
//  ExpenditureApp
//
//  Created by VC on 30/07/26.
//
import Foundation

struct ExpenseIncomeRecord: Identifiable {

    let id = UUID()

    let title: String
    let amount: Double
    let date: Date
    let isIncome: Bool

    let expenseNo: UUID?
    let incomeNo: UUID?
}
