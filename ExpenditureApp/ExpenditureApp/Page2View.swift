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
    
    
    @State private var expense = ""
    @State private var amount = ""
    @Environment(\.dismiss) private var dismiss
    var editingExpense: Expenses? = nil
    
    var body: some View {
        
        
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
                        
                        if let editingExpense = editingExpense {
                            print("UUID from Page2:")
                               print(editingExpense.expenseNo!)
                            
                            CoreDataManager.shared.updateExpense(
                                expenseNo: editingExpense.expenseNo!,
                                expenseTitle: expense,
                                expenseAmount: Double(amount) ?? 0.0,
                                expenseDate: selectedDate
                            )
                            
                        } else {
                            
                            let newExpense = Expense(
                                expenseDate: selectedDate,
                                expenseAmount: Double(amount) ?? 0.0,
                                expenseTitle: expense,
                                expenseNo: UUID()
                            )
                            
                            CoreDataManager.shared.saveExpense(expense: newExpense)
                            
                        }
                        
                        expense = ""
                        amount = ""
                        dismiss()
                    }
                    
                } label: {
                    
                    Text(editingExpense == nil ? "Add" : "Update")
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
            Spacer()
            
        }
       
        .padding()
        .navigationTitle("Add Expense")
        .navigationBarTitleDisplayMode(.inline)
       
       
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
        
        
        .background(
            LinearGradient(
                colors: [
                    Color.green.opacity(0.55),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        
       
        .onAppear {

            if let editingExpense = editingExpense {

                expense = editingExpense.expenseTitle ?? ""
                amount = String(editingExpense.expenseAmount)
                selectedDate = editingExpense.expenseDate ?? Date()

            } else {

                expense = ""
                amount = ""
                selectedDate = Date()

            }
        }
       

    }
    
    
}


#Preview {
    NavigationStack {
        Page2View()
    }
    
}


