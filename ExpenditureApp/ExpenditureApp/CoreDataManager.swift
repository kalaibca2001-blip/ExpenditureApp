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

        do {
            try context.save()
            print("Saved Successfully")
        } catch {
            print(error.localizedDescription)
        }
    }
//    func saveExpense() {
//
//        let expense = Expenses(context: context)
//
//        expense.expenseNo = 12
//        expense.expenseTitle = "Food"
//        expense.expenseAmount = 25.0
//
//        do {
//
//            try context.save()
//
//            print("Saved Successfully")
//            let fetchData = fetchExpenses()
//            for result in fetchData {
//
//                print(result.expenseNo)
//                print(result.expenseTitle ?? "")
//                print(result.expenseAmount)
//
//            }
//            print(fetchData)
//
//        } catch {
//
//            print(error.localizedDescription)
//
//        }
//
//    }
//    
    func fetchExpenses() -> [Expenses] {

        let request: NSFetchRequest<Expenses> = Expenses.fetchRequest()

        do {

            return try context.fetch(request)

        } catch {

            return []

        }
    }

}
