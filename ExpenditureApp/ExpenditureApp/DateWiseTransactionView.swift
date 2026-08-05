//
//  Datewise.swift
//  ExpenditureApp
//
//  Created by VC on 30/07/26.
//
import SwiftUI
import CoreData

struct DateWiseTransactionView: View {

    let selectedDate: Date
    @State private var records: [ExpenseIncomeRecord] = []
//    @State private var expenses: [Expenses] = []
    @State private var incomes: [Income] = []
    func loadRecords() {

        let expenses = CoreDataManager.shared.fetchExpenses(for: selectedDate)
        let incomes = CoreDataManager.shared.fetchIncome(for: selectedDate)

        var combinedRecords: [ExpenseIncomeRecord] = []

        // Expense Records
        for expense in expenses {

            combinedRecords.append(
                ExpenseIncomeRecord(
                    title: expense.expenseTitle ?? "",
                    amount: expense.expenseAmount,
                    date: expense.expenseDate ?? Date(),
                    isIncome: false,
                    expenseNo: expense.expenseNo,
                    incomeNo: nil
                )
            )
        }

        // Income Records
        for income in incomes {

            combinedRecords.append(
                ExpenseIncomeRecord(
                    title: income.incomeTitle ?? "",
                    amount: income.incomeAmount,
                    date: income.incomeDate ?? Date(),
                    isIncome: true,
                    expenseNo: nil,
                    incomeNo: income.incomeNo
                )
            )
        }

        records = combinedRecords.sorted { $0.date < $1.date }
    }

    var body: some View {

        VStack {

            VStack(spacing: 0) {

                // Header
                HStack(spacing: 0) {

                    Text("S.No")
                        .frame(width: 50)

                    Divider()

                    Text("Title")
                        .frame(maxWidth: .infinity)

                    Divider()

                    Text("Type")
                        .frame(width: 60)

                    Divider()

                    Text("Amount")
                        .frame(width: 90)

                    Divider()

                    Text("Action")
                        .frame(width: 90)

                }
                .font(.headline)
                .frame(height: 45)
                .background(Color.blue.opacity(0.15))

                Divider()

            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            
            
            ForEach(Array(records.enumerated()), id: \.element.id) { index, record in

                TransactionRowView(
                    sno: "\(index + 1)",
                    title: record.title,
                    typeIcon: record.isIncome
                        ? "chart.line.uptrend.xyaxis"
                        : "chart.line.downtrend.xyaxis",
                    typeColor: record.isIncome ? .green : .red,
                    amount: "₹\(Int(record.amount))",
                    onEdit: {

                    },
                    onDelete: {

                        if record.isIncome {

                            if let incomeNo = record.incomeNo {
                                CoreDataManager.shared.deleteIncome(incomeNo: incomeNo)
                            }

                        } else {

                            if let expenseNo = record.expenseNo {
                                CoreDataManager.shared.deleteExpense(expenseNo: expenseNo)
                            }
                        }

                        loadRecords()
                    }
                )
                .background(Color.white)
                .cornerRadius(12)
            }
            
            Spacer()
            
            
        }
        .onAppear {
            loadRecords()
        }

        
        .navigationTitle(selectedDate.formatted(date: .abbreviated, time: .omitted))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.blue.opacity(0.08))
    }
}

#Preview {
    NavigationStack {
        DateWiseTransactionView(selectedDate: Date())
    }
}
