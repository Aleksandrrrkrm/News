//
//  CoreDataStack.swift
//  Intro-Lab
//
//  Created by Александр Головин on 05.02.2023.
//

import Foundation
import CoreData

final class CoreStack {
    
    static var shared = CoredataStack(modelName: "Intro_Lab")
    
    fileprivate init () {}
}

final class CoredataStack {
    
    fileprivate var modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context: NSManagedObjectContext = .init(concurrencyType: .privateQueueConcurrencyType)
        context.parent = managedContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
        return persistentContainer
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else {
#if DEBUG
            print("@@ managedContext без изменений")
#endif
            return
        }
        do {
            try managedContext.save()
        } catch let error {
#if DEBUG
            print("@@ ошибка сохранения \(error)")
#endif
        }
    }
}
