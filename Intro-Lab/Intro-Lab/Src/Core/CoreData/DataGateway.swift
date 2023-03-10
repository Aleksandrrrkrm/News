//
//  DataGateway.swift
//  Intro-Lab
//
//  Created by Александр Головин on 05.02.2023.
//

import Foundation
import CoreData

protocol CacheNewsGateway: AnyObject {
    
    func getNews(predicate: NSPredicate?,
                         sortDescriptors: [NSSortDescriptor]?) -> [DataArticle]?
    
    func deleteNew(_ data: DataArticle)
    
    func deleteAllNews()
    
    func saveNews(_ data: [DataModel], completion: (() -> ())?)
    
    func saveContext()
}

class CacheTransactionGatewayImp: CacheNewsGateway {
    
    fileprivate let coreDataStack: CoredataStack
    
    init(coreDataStack: CoredataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func getNews(predicate: NSPredicate?,
                         sortDescriptors: [NSSortDescriptor]?) -> [DataArticle]? {
        let fetchRequest: NSFetchRequest<DataArticle> = DataArticle.fetchRequest()
        if let predicate {
            fetchRequest.predicate = predicate
        }
        if let sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            return try coreDataStack.managedContext.fetch(fetchRequest)
        } catch let error {
#if DEBUG
            print("@@ ошибка получения новостей \(error.localizedDescription)")
#endif
            return nil
        }
    }
    
    func deleteNew(_ data: DataArticle) {
        coreDataStack.managedContext.delete(data)
        coreDataStack.saveContext()
    }
    
    func deleteAllNews() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "DataArticle")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            try coreDataStack.managedContext.execute(deleteRequest)
#if DEBUG
            print("@@ полностью удалено")
#endif
            
        } catch let error {
#if DEBUG
            print("@@ ошибка удаления\(error.localizedDescription)")
#endif
        }
    }
    
    func saveNews(_ data: [DataModel], completion: (() -> ())?) {
        coreDataStack.backgroundContext.perform { [weak self] in
            guard let context = self?.coreDataStack.backgroundContext else {
                return
            }
            
            context.perform {
                data.forEach {
                    let model = DataArticle(context: context)
                    model.mainTitle = $0.mainTitle
                    model.descriptionTitle = $0.descriptionTitle
                    model.publishedAt = $0.publishedAt
                }
            }
            do {
                try context.save()
#if DEBUG
                print("@@ сохраненно")
#endif
                DispatchQueue.main.async {
                    self?.saveContext()
                    completion?()
                }
            } catch let error {
#if DEBUG
                print("@@ ошибка сохраненияфя\(error.localizedDescription)")
#endif
            }
        }
    }
    
    func saveContext() {
        coreDataStack.saveContext()
    }
}
