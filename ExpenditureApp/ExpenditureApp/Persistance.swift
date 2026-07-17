//
//  Persistance.swift
//  ExpenditureApp
//
//  Created by VC on 17/07/26.
//

import CoreData

final class PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {

        container = NSPersistentContainer(name: "Expenditure")

        container.loadPersistentStores { _, error in

            if let error = error {

                fatalError("Core Data Error : \(error)")

            }

        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    var context: NSManagedObjectContext {

        container.viewContext

    }
}
