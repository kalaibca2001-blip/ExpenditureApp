//
//  HomeViewNew.swift
//  ExpenditureApp
//
//  Created by VC on 26/07/26.
//
import SwiftUI


struct HomeViewNew: View {
    
    @State private var expenses: [Expenses] = []
    @State private var income: [Income] = []
    @State private var transactionDates: [Date] = []
    
    var totalExpense: Double {
        expenses.reduce(0) { $0 + $1.expenseAmount }
    }
    
    var totalIncome: Double {
        income.reduce(0) { $0 + $1.incomeAmount }
    }
    
    //1
    var hasTransactions: Bool {
        !transactionDates.isEmpty
    }
    
    
    //2
    var hasToday: Bool {
        
        guard let firstDate = transactionDates.first else {
            return false
        }
        
        return Calendar.current.isDateInToday(firstDate)
    }
    
    //3
    var hasYesterday: Bool {

        let calendar = Calendar.current

        return transactionDates.contains {

            calendar.isDateInYesterday($0)

        }
    }

    //4
    var lastActivityDate: Date? {

        if hasToday && hasYesterday {
            return nil
        }

        if hasToday {

            guard transactionDates.count > 1 else {
                return nil
            }

            return transactionDates[1]
        }

        if hasYesterday {

            guard transactionDates.count > 1 else {
                return nil
            }

            return transactionDates[1]
        }

        return transactionDates.first
    }

    //5
    var showLoadMore: Bool {

        if hasToday && hasYesterday {

            return transactionDates.count >= 3

        }

        return transactionDates.count >= 4
    }
    
  
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                ZStack {

                    Text("Overview")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack {

                        Spacer()

                        NavigationLink {
                            LoadMoreDatesView()
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .padding(.horizontal)
                
                // MARK: - Expense & Income
                
                HStack(spacing: 10) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Total Expense")
                            .font(.headline)
                        
                        Text("₹\(totalExpense, specifier: "%.2f")")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.red)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.08), radius: 8)
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Total Income")
                            .font(.headline)
                        
                        Text("₹\(totalIncome, specifier: "%.2f")")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.green)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.08), radius: 8)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - Balance
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Current Balance")
                        .font(.headline)
                    
                    Text("₹\(totalIncome - totalExpense, specifier: "%.2f")")
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
                    
                    Text("Recent Activity")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal)
                
                if hasTransactions {
                    
                    VStack(spacing: 15) {
                        
                        // Today
                        if hasToday {
                            
                            NavigationLink {
                                DateWiseTransactionView(selectedDate: Date())
                            } label: {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("Today")
                                        .font(.headline)
                                    
                                    HStack {
                                        
                                        Text(Date().formatted(date: .abbreviated, time: .omitted))
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 70)
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.08), radius: 8)
                            }
                            .buttonStyle(.plain)
                        }
                        // Yesterday
                        
                        if hasYesterday {
                            NavigationLink {
                                
                                DateWiseTransactionView(
                                    selectedDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                                )
                                
                            } label: {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("Yesterday")
                                        .font(.headline)
                                    
                                    HStack {
                                        
                                        Text(
                                            Calendar.current
                                                .date(byAdding: .day, value: -1, to: Date())!
                                                .formatted(date: .abbreviated, time: .omitted)
                                        )
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 70)
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.08), radius: 8)
                            }
                            .buttonStyle(.plain)
                        }
                        
                        
                        if !showLoadMore,
                           let lastDate = lastActivityDate {
                            
                            NavigationLink {
                                
                                DateWiseTransactionView(selectedDate: lastDate)
                                
                            } label: {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("Last Activity")
                                        .font(.headline)
                                    
                                    HStack {
                                        
                                        Text(lastDate.formatted(date: .abbreviated, time: .omitted))
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                        
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 70)
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.08), radius: 8)
                            }
                            .buttonStyle(.plain)
                        }
                        
                        // Load More Dates
                        
                        if showLoadMore {
                            NavigationLink {
                                
                                LoadMoreDatesView()
                                
                            } label: {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("Load More Dates")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    HStack {
                                        
                                        Text("Browse Transactions")
                                            .foregroundColor(.blue)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 80)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.08), radius: 8)
                            }
                        }
                        
                    }
                    
                } else {
                    
                    VStack(spacing: 15) {
                        
                        Image(systemName: "wallet.bifold.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.blue)
                        
                        Text("No Transactions Yet")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Start tracking your income and expenses.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                        
                        Text("Tap the + button below to add your first record.")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 40)
                }
                
                Spacer(minLength: 30)
                
            }
            .padding(.top, 20)
            .overlay(alignment: .bottom) {
                
                NavigationLink {
                    
                    Page2View()
                    
                } label: {
                    
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding(.bottom, 10)
                
            }
            
            .background(
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.39),
                        Color.mint.opacity(0.29)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .onAppear {
                expenses = CoreDataManager.shared.fetchExpenses()
                income = CoreDataManager.shared.fetchIncome()
                transactionDates = CoreDataManager.shared.fetchTransactionDates()
                
            }
            
            
        }
      
           
        }
        
    }


#Preview {
    HomeViewNew()
}

