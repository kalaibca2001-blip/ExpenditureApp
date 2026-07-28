//
//  HomeView.swift
//  ExpenditureApp
//
//  Created by VC on 04/07/26.
//
//
//    import SwiftUI
//    
//    struct HomeView: View {
//        
//        @State private var expenses: [Expenses] = []
//        
//        var body: some View {
//            
//            VStack{
//                
//
//                
//                if expenses.isEmpty {
//                    
//                    Text("Manage your expense")
//                                       .font(.title2)
//                                       .fontWeight(.semibold)
//                                       .padding(.top,60-20)
//                    Spacer()
//                    
//                    Image("budget")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 350)
//                    
//                    Spacer()
//                    
//                } else {
//                    
//                    Text("Expense Records")
//                        .padding(.top, 50)
//                    VStack(alignment: .leading, spacing: 20) {
//                        
//                        Text("Total Balance")
//                            .font(.title2)
//                            .bold()
//                        
//                        RoundedRectangle(cornerRadius: 20)
//                            .fill(
//                                LinearGradient(
//                                    colors: [.blue, .blue.opacity(0.45)],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                )
//                            )
//                            .frame(height: 90)
//                            .overlay {
//
//                                VStack(alignment: .leading, spacing: 10) {
//
//                                    Text("Available Balance")
//                                        .foregroundColor(.white.opacity(0.9))
//
//                                    Text("₹\(totalAmount(), specifier: "%.2f")")
//                                        .font(.system(size: 36))
//                                        .bold()
//                                        .foregroundColor(.white)
//
//                                }
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding()
//                            }
//
//                        Text("Latest spending")
//                            .font(.title2)
//                            .bold()
//
//                        ScrollView {
//
//                            LazyVStack(spacing:15) {
//
//                                ForEach(expenses.indices, id: \.self) { index in
//
//                                    VStack(alignment: .leading, spacing: 5) {
//
//                                        HStack {
//
//                                            Text("#\(index + 1)")
//                                                .font(.headline)
//                                                .foregroundColor(.gray)
//
//                                            Spacer()
//
//                                            Text("₹\(expenses[index].expenseAmount, specifier: "%.2f")")
//                                                .font(.title3)
//                                                .bold()
//                                                .foregroundColor(.green)
//                                        }
//
//                                        Text(expenses[index].expenseTitle ?? "")
//                                            .font(.title3)
//                                            .fontWeight(.semibold)
//
//                                        Divider()
//
//                                        HStack {
//
//                                            NavigationLink {
//
//                                                Page2View(editingExpense: expenses[index])
//
//                                            } label: {
//
//                                                Label("Edit", systemImage: "square.and.pencil")
//                                                    .foregroundColor(.blue)
//                                            }
//
//                                            Spacer()
//
//                                            Button {
//
//                                                if let expenseNo = expenses[index].expenseNo {
//
//                                                    CoreDataManager.shared.deleteExpense(expenseNo: expenseNo)
//                                                    loadExpenses()
//
//                                                }
//
//                                            } label: {
//
//                                                Label("Delete", systemImage: "trash")
//                                                    .foregroundColor(.red)
//                                            }
//                                        }
//
//                                    }
//                                    .padding()
//                                    .background(Color.white)
//                                    .cornerRadius(18)
//                                    .shadow(radius: 10)
//                                }
//                            }
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.top, 30)
//                }
//                   
//                
//                
//                Spacer()
//                
//                NavigationLink {
//                    
//                    Page2View()
//                    
//                } label: {
//                    
//                    Image(systemName: "plus")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .clipShape(Circle())
//                        .shadow(radius: 20)
//                    
//                }
//                .padding(.bottom)
//                
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(
//                LinearGradient(
//                    colors: [
//                        Color.blue.opacity(0.55),
//                        Color.green.opacity(0.25)
//                    ],
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//            )
//            .onAppear {
//                loadExpenses()
//            }
//        }
//        
//        func loadExpenses() {
//
//            expenses = Array(CoreDataManager.shared.fetchExpenses().reversed())
//
//            print("Total Expenses: \(expenses.count)")
//        
//        }
//        func totalAmount() -> Double {
//
//            expenses.reduce(0) { partialResult, expense in
//                partialResult + expense.expenseAmount
//            }
//
//        }
//    }
//    
//    #Preview {
//        NavigationStack {
//            HomeView()
//        }
//    }

