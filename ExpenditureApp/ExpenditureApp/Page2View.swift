//
//  Page2View.swift
//  ExpenditureApp
//
//  Created by VC on 04/07/26.
//
import SwiftUI

struct Page2View: View {
    @ObservedObject var store: ExpenseStore
    
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    
    @State private var expense = ""
    @State private var amount = ""
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                
                // Date selection and Clear button
                HStack {
                    
                    Text("Date")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button("Clear") {
                        expense = ""
                        amount = ""
                        selectedDate = Date()
                        store.expenses.removeAll()
                    }
                    .foregroundColor(.blue)
                    .font(.headline)
                }
                
                // Date Picker Row with calender
                HStack {
                    
                    Text(selectedDate.formatted(date: .numeric, time: .omitted))
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
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )
                
                // Expense and expense textfield
                Text("Expense")
                    .font(.headline)
                
                TextField("Enter Expense", text: $expense)
                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .font(.body)
                
                // Amount and amount textfield
                Text("Amount")
                    .font(.headline)
                
                TextField("Enter Amount", text: $amount)
                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .font(.body)
                    .keyboardType(.decimalPad)
                // Update Button to update in home view or to move homeview 
                HStack {
                    
                    Spacer()
                    
                    Button {
                        
                        if !expense.isEmpty && !amount.isEmpty {
                            
                            let newExpense = Expense(
                                name: expense,
                                amount: amount
                            )
                            
                            store.expenses.append(newExpense)
                            expense = ""
                            amount = ""
                        }
                        
                    } label: {
                        
                        
                        Text("Update")
                            .font(.headline)
                            .fontWeight(.medium)
                            .frame(width: 120, height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                }
                
//                // Expenses List
//                Text("Today's Expenses")
//                    .font(.headline)
//                    .padding(.top)
//
//                ForEach(store.expenses.indices, id: \.self) { index in
//                    HStack {
//
//                        Text(store.expenses[index].name)
//
//                        Spacer()
//
//                        Text("₹\(store.expenses[index].amount)")
//                    }
//                    .padding(.vertical, 5)
//                }
                
//                Spacer()
            }
            .padding()
            
            .navigationTitle("Add Expense")
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
                    .background(Color(red: 0.94, green: 0.90, blue: 0.97))
                }
            }
        }
        .background(
            LinearGradient(
                colors: [
                    Color.green.opacity(0.55),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
    
    #Preview {
        NavigationStack {
            Page2View(store: ExpenseStore())
        }
    }
    

