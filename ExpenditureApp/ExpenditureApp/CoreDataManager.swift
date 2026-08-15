//
//  CoreDataManager.swift
//  ExpenditureApp
//
//  Created by VC on 17/07/26.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private let context = PersistenceController.shared.context
    
    // MARK: - Current Logged-In User
    
    private var currentUserEmail: String {
        KeychainManager.shared.read(forKey: "email") ?? ""
    }
    
    
    // MARK: - Expense
    
    func saveExpense(
        title: String,
        amount: Double,
        date: Date
    ) {
        
        let dbExpense = Expenses(context: context)
        
        dbExpense.expenseNo = UUID()
        dbExpense.expenseTitle = title
        dbExpense.expenseAmount = amount
        dbExpense.expenseDate = date
        dbExpense.expenseIsDeleted = false
        dbExpense.userEmail = currentUserEmail
        
        do {
            try context.save()
            print("Expense Saved Successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchExpenses() -> [Expenses] {
        
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        
        request.predicate = NSPredicate(
            format: "expenseIsDeleted == %@ AND userEmail == %@",
            NSNumber(value: false),
            currentUserEmail
        )
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    // MARK: - Find Expense
    
    func findExpense(by expenseNo: UUID) -> Expenses? {
        
        print("Searching for UUID:")
        print(expenseNo)
        
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        
        request.predicate = NSPredicate(
            format: "expenseNo == %@ AND userEmail == %@",
            expenseNo as CVarArg,
            currentUserEmail
        )
        
        do {
            
            let expenses = try context.fetch(request)
            
            return expenses.first
            
        } catch {
            
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    
    // MARK: - Update Expense
    
    func updateExpense(
        expenseNo: UUID,
        expenseTitle: String,
        expenseAmount: Double,
        expenseDate: Date
    ) {
        
        print("Update function called")
        
        guard let expense = findExpense(by: expenseNo) else {
            return
        }
        
        print("Expense found")
        
        expense.expenseTitle = expenseTitle
        expense.expenseAmount = expenseAmount
        expense.expenseDate = expenseDate
        
        do {
            try context.save()
            print("Updated Successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Delete Expense
    
    func deleteExpense(expenseNo: UUID) {
        
        guard let expense = findExpense(by: expenseNo) else {
            return
        }
        
        expense.expenseIsDeleted = true
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Today's Expenses
    
    func fetchTodayExpenses() -> [Expenses] {
        
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(
            byAdding: .day,
            value: 1,
            to: startOfDay
        )!
        
        request.predicate = NSPredicate(
            format: "expenseDate >= %@ AND expenseDate < %@ AND expenseIsDeleted == %@ AND userEmail == %@",
            startOfDay as NSDate,
            endOfDay as NSDate,
            NSNumber(value: false),
            currentUserEmail
        )
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    // MARK: - Expenses For Selected Date
    
    func fetchExpenses(for date: Date) -> [Expenses] {
        
        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(
            byAdding: .day,
            value: 1,
            to: startOfDay
        )!
        
        request.predicate = NSPredicate(
            format: "expenseDate >= %@ AND expenseDate < %@ AND expenseIsDeleted == %@ AND userEmail == %@",
            startOfDay as NSDate,
            endOfDay as NSDate,
            NSNumber(value: false),
            currentUserEmail
        )
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    // MARK: - Income
    
    func saveIncome(
        title: String,
        amount: Double,
        date: Date
    ) {
        
        let dbIncome = Income(context: context)
        
        dbIncome.incomeNo = UUID()
        dbIncome.incomeTitle = title
        dbIncome.incomeAmount = amount
        dbIncome.incomeDate = date
        dbIncome.incomeIsDeleted = false
        dbIncome.userEmail = currentUserEmail
        
        do {
            try context.save()
            print("Income Saved Successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchIncome() -> [Income] {
        
        let request: NSFetchRequest<Income> = Income.fetchRequest()
        
        request.predicate = NSPredicate(
            format: "incomeIsDeleted == %@ AND userEmail == %@",
            NSNumber(value: false),
            currentUserEmail
        )
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    // MARK: - Total Income
    
    func totalIncome() -> Double {
        
        let incomes = fetchIncome()
        
        return incomes.reduce(0) {
            $0 + $1.incomeAmount
        }
    }
    
    
    // MARK: - Find Income
    
    func findIncome(by incomeNo: UUID) -> Income? {
        
        let request: NSFetchRequest<Income> = Income.fetchRequest()
        
        request.predicate = NSPredicate(
            format: "incomeNo == %@ AND userEmail == %@",
            incomeNo as CVarArg,
            currentUserEmail
        )
        
        do {
            return try context.fetch(request).first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    // MARK: - Update Income
    
    func updateIncome(
        incomeNo: UUID,
        incomeTitle: String,
        incomeAmount: Double,
        incomeDate: Date
    ) {
        
        guard let income = findIncome(by: incomeNo) else {
            return
        }
        
        income.incomeTitle = incomeTitle
        income.incomeAmount = incomeAmount
        income.incomeDate = incomeDate
        
        do {
            try context.save()
            print("Income Updated Successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Delete Income
    
    func deleteIncome(incomeNo: UUID) {
        
        guard let income = findIncome(by: incomeNo) else {
            return
        }
        
        income.incomeIsDeleted = true
        
        do {
            try context.save()
            print("Income Soft Deleted Successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Income For Selected Date
    
    func fetchIncome(for date: Date) -> [Income] {
        
        let request: NSFetchRequest<Income> = Income.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(
            byAdding: .day,
            value: 1,
            to: startOfDay
        )!
        
        request.predicate = NSPredicate(
            format: "incomeDate >= %@ AND incomeDate < %@ AND incomeIsDeleted == %@ AND userEmail == %@",
            startOfDay as NSDate,
            endOfDay as NSDate,
            NSNumber(value: false),
            currentUserEmail
        )
        
        do {
            return try context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    // MARK: - Transaction Dates
    
    func fetchTransactionDates() -> [Date] {
        
        let expenses = fetchExpenses()
        let income = fetchIncome()
        
        var dates: [Date] = []
        
        for expense in expenses {
            
            if let expenseDate = expense.expenseDate {
                dates.append(expenseDate)
            }
        }
        
        for incomeItem in income {
            
            if let incomeDate = incomeItem.incomeDate {
                dates.append(incomeDate)
            }
        }
        
        let calendar = Calendar.current
        
        let uniqueDates = Dictionary(
            grouping: dates,
            by: {
                calendar.startOfDay(for: $0)
            }
        ).map {
            $0.key
        }
        
        let sortedDates = uniqueDates.sorted(by: >)
        
        return sortedDates
    }
    
    
    // MARK: - Transaction Dates Between Two Dates
    
    func fetchTransactionDates(
        from fromDate: Date,
        to toDate: Date
    ) -> [Date] {
        
        let allDates = fetchTransactionDates()
        
        let calendar = Calendar.current
        
        let startDate = calendar.startOfDay(for: fromDate)
        
        let endDate = calendar.date(
            byAdding: .day,
            value: 1,
            to: calendar.startOfDay(for: toDate)
        )!
        
        let filteredDates = allDates.filter {
            $0 >= startDate && $0 < endDate
        }
        
        return filteredDates
    }
}
