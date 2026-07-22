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
    
    func saveExpense(expense:Expense) {
        
        let dbexpense = Expenses(context: context)
        
        dbexpense.expenseNo = expense.expenseNo
        dbexpense.expenseTitle = expense.expenseTitle
        dbexpense.expenseAmount = expense.expenseAmount
        dbexpense.expenseDate = expense.expenseDate
        dbexpense.expenseIsDeleted = false
        do {
            try context.save()
            print("Saved Successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchExpenses() -> [Expenses] {

        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()

        request.predicate = NSPredicate(
            format: "expenseIsDeleted == %@",
            NSNumber(value: false)
        )

        do {
            return try context.fetch(request)
        } catch {
            return []
        }

    }   
    //this reusable function can be used in both the edit and delete buttons to follw the content that can be easy to modify through this
    
  
    
    func findExpense(by expenseNo: UUID) -> Expenses? {
        print("Searching for UUID:")
            print(expenseNo)


        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()

        request.predicate = NSPredicate(format: "expenseNo == %@", expenseNo as CVarArg)
        do {

            let expenses = try context.fetch(request)

            return expenses.first

        } catch {

            print(error.localizedDescription)

            return nil

        }
       
    }
    
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

}
