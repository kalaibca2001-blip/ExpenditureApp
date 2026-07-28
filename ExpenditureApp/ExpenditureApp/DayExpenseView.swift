//
//  DayExpenseView.swift
//  ExpenditureApp
//
//  Created by VC on 26/07/26.
//
import SwiftUI

struct DayExpenseView: View {

    @State private var todayExpenses: [Expenses] = []

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color.blue.opacity(0.55),
                    Color.green.opacity(0.25)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {

                VStack(spacing: 20) {

                    // MARK: - Title

                    Text("Today's Spending")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    // MARK: - Table Header

                    HStack {

                        Text("Expense")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Amount")
                            .font(.headline)
                            .frame(width: 100, alignment: .center)

                        Text("Delete")
                            .font(.headline)
                            .frame(width: 60, alignment: .center)
                    }
                    .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)

                    // MARK: - Expense List

                    ForEach(todayExpenses, id: \.expenseNo) { expense in

                        HStack {

                            Text(expense.expenseTitle ?? "")
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("₹\(expense.expenseAmount, specifier: "%.2f")")
                                .frame(width: 100, alignment: .center)

                            Button {

                                if let id = expense.expenseNo {
                                    CoreDataManager.shared.deleteExpense(expenseNo: id)
                                    todayExpenses = CoreDataManager.shared.fetchTodayExpenses()
                                }

                            } label: {

                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .frame(width: 60, alignment: .center)
                        }
                        .padding(.horizontal)

                        Divider()
                            .padding(.horizontal)
                    }

                    Spacer(minLength: 20)
                }
                .onAppear {
                    todayExpenses = CoreDataManager.shared.fetchTodayExpenses()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DayExpenseView()
    }
}
