//
//  HomeViewNew.swift
//  ExpenditureApp
//
//  Created by VC on 26/07/26.
//
import SwiftUI

struct HomeViewNew: View {
    
    @State private var todayExpenses: [Expenses] = []
    
    @State private var expenses: [Expenses] = []
    
    @State private var isEditingIncome = false
    @State private var totalIncome = ""
    
    var todayTotal: Double {
        todayExpenses.reduce(0) { $0 + $1.expenseAmount }
    }
    
    var body: some View {
        
        NavigationStack {
            
            
            ScrollView {
                
                
                VStack(spacing: 20) {
                    
                    Text("Expense Records")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    // MARK: - Expense & Income
                    
                    HStack(spacing: 10) {
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Total Expense")
                                .font(.headline)
                            
                            Text("₹\(totalExpense(), specifier: "%.2f")")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.red)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.08), radius: 8)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            HStack {
                                
                                Text("Total Income")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Button {
                                    isEditingIncome.toggle()


                                    
                                } label: {
                                    
                                    Image(systemName: "square.and.pencil")
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            if isEditingIncome {

                                TextField("₹0.00", text: $totalIncome)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.green)
                                    .multilineTextAlignment(.leading)
                                    .textFieldStyle(.plain)

                            } else {

                                Text(totalIncome.isEmpty ? "₹0.00" : "₹\(totalIncome)")
                                    .font(  .system(size: 30, weight: .bold))
                                    .foregroundColor(.green)
                                   
                            }
                        
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.08), radius: 8)
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Current Balance
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Current Balance")
                            .font(.headline)
                        
                        Text("₹\(totalExpense(), specifier: "%.2f")")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.blue)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.08), radius: 8)
                    .padding(.horizontal)
                    
                    // MARK: - Latest Spending
                    
                    HStack {
                        
                        Text("Latest Spending")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Date Cards
                    
                    VStack(spacing: 15) {
                        
                        // Today Card
                        NavigationLink {
                            
                            DayExpenseView()
                        } label: {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Today")
                                    .font(.headline)
                                
                                HStack{
                                    Text("₹\(todayTotal, specifier: "%.2f")")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    
                                    
                                }
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 80)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.08), radius: 8)
                        }
                        
                        // Yesterday Card
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Yesterday")
                                .font(.headline)
                            
                            HStack{
                                Text("₹0.00")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 80)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.08), radius: 8)
                        
                        // 22 Jul Card
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("22 Jul")
                                .font(.headline)
                            
                            HStack{
                                Text("₹0.00")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            
                            
                          
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 80)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.08), radius: 8)
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 30)
                    
                }
               
                .onAppear {
                    todayExpenses = CoreDataManager.shared.fetchTodayExpenses()
                }
        }
            
            .overlay(alignment: .bottom){

                NavigationLink {

                    Page2View()

                } label: {

                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 8)

                }
//                .padding(.trailing, 25)
                .padding(.bottom, 30)

            }
         
               
                
            
            .background {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.55),
                        Color.green.opacity(0.25)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        .onAppear {
            todayExpenses = CoreDataManager.shared.fetchTodayExpenses()
            loadExpenses()
        }
        }
    func loadExpenses() {
        expenses = Array(CoreDataManager.shared.fetchExpenses().reversed())
    }
    func totalExpense() -> Double {
        expenses.reduce(0) { $0 + $1.expenseAmount }
    }
    
    }
#Preview {
    HomeViewNew()
}
