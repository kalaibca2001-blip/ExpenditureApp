//
//  Page2View.swift
//  ExpenditureApp
//
//  Created by VC on 04/07/26.
//

import SwiftUI

struct Page2View: View {
    
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    @State private var isIncome = false
    
    @State private var expense = ""
    @State private var amount = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var editingExpense: Expenses? = nil
    var editingIncome: Income? = nil
    
    
    var body: some View {
        
        ZStack {
            
            //  Full Page Background
            
            Image("expenseGrowth")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            //  Page Content
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Date Selection
                    
                    HStack {
                        
                        Text("Date")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button("Clear") {
                            expense = ""
                            amount = ""
                            selectedDate = Date()
                        }
                        .foregroundColor(.blue)
                        .font(.headline)
                    }
                    
                    
                    //  Date Picker Row
                    
                    HStack {
                        
                        Text(
                            selectedDate.formatted(
                                date: .numeric,
                                time: .omitted
                            )
                        )
                        .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button {
                            showDatePicker = true
                        } label: {
                            Image(systemName: "calendar")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.85))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray)
                    )
                    
                    
                    // Expense / Income
                    
                    HStack {
                        
                        Text(isIncome ? "Income" : "Expense")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Toggle("", isOn: $isIncome)
                            .labelsHidden()
                            .scaleEffect(0.75)
                    }
                    
                    
                    // Expense / Income TextField
                    
                    TextField(
                        isIncome ? "Enter Income" : "Enter Expense",
                        text: $expense
                    )
                    .padding()
                    .tint(.blue)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    
                    
                    //  Amount
                    
                    Text("Amount")
                        .font(.headline)
                    
                    
                    TextField(
                        "Enter Amount",
                        text: $amount
                    )
                    .padding()
                    .tint(.blue)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .font(.body)
                    .keyboardType(.decimalPad)
                    
                    
                    //  Add / Update Button
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            
                            if !expense.isEmpty && !amount.isEmpty {
                                
                                //  Income
                                
                                if isIncome {
                                    
                                    if let editingIncome = editingIncome {
                                        
                                        CoreDataManager.shared.updateIncome(
                                            incomeNo: editingIncome.incomeNo!,
                                            incomeTitle: expense,
                                            incomeAmount: Double(amount) ?? 0.0,
                                            incomeDate: selectedDate
                                        )
                                        
                                    } else {
                                        
                                        CoreDataManager.shared.saveIncome(
                                            title: expense,
                                            amount: Double(amount) ?? 0.0,
                                            date: selectedDate
                                        )
                                    }
                                    
                                } else {
                                    
                                    //  Expense
                                    
                                    if let editingExpense = editingExpense {
                                        
                                        CoreDataManager.shared.updateExpense(
                                            expenseNo: editingExpense.expenseNo!,
                                            expenseTitle: expense,
                                            expenseAmount: Double(amount) ?? 0.0,
                                            expenseDate: selectedDate
                                        )
                                        
                                    } else {
                                        
                                        CoreDataManager.shared.saveExpense(
                                            title: expense,
                                            amount: Double(amount) ?? 0.0,
                                            date: selectedDate
                                        )
                                    }
                                }
                                
                                expense = ""
                                amount = ""
                                
                                dismiss()
                            }
                            
                        } label: {
                            
                            Text(
                                editingExpense == nil &&
                                editingIncome == nil
                                ? "Add"
                                : "Update"
                            )
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(
                                width: 100,
                                height: 35
                            )
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                        
                        Spacer()
                    }
                    
                    // Small space at the bottom
                    Spacer(minLength: 20)
                }
                .padding()
                .padding(.top, 75)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        
        
        //  Navigation
        
        .navigationTitle(
            isIncome
            ? "Add Income"
            : "Add Expense"
        )
        .navigationBarTitleDisplayMode(.inline)
        
        
        //  Date Picker Sheet
        
        .sheet(isPresented: $showDatePicker) {
            
            NavigationStack {
                
                VStack {
                    
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .padding()
                    
                    Button("Done") {
                        showDatePicker = false
                    }
                    .padding()
                }
                .navigationTitle("Choose Date")
                .background(
                    Color(
                        red: 0.94,
                        green: 0.90,
                        blue: 0.97
                    )
                )
            }
        }
        
        
        //  Load Existing Data
        
        .onAppear {
            
            if let editingExpense = editingExpense {
                
                expense = editingExpense.expenseTitle ?? ""
                amount = String(editingExpense.expenseAmount)
                selectedDate = editingExpense.expenseDate ?? Date()
                isIncome = false
                
            } else if let editingIncome = editingIncome {
                
                expense = editingIncome.incomeTitle ?? ""
                amount = String(editingIncome.incomeAmount)
                selectedDate = editingIncome.incomeDate ?? Date()
                isIncome = true
                
            } else {
                
                expense = ""
                amount = ""
                selectedDate = Date()
                isIncome = false
            }
        }
    }
}




#Preview {
    NavigationStack {
        Page2View()
    }
}

