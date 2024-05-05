//
//  CoreDataManager.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 01/05/2024.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func fetch<U: NSManagedObject>(request: NSFetchRequest<U>) -> Result<[U], Error>
    func add<U: NSManagedObject>(entityType: U.Type, mapper: CoreDataModelMapper)
//    func update()
//    func delete()
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    var persistentContainerName : String
    static let shared: CoreDataManager = CoreDataManager()
    
    private init(persistentContainerName: String = "NewsModel") {
        self.persistentContainerName = persistentContainerName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func fetch<U: NSManagedObject>(request: NSFetchRequest<U>) -> Result<[U], Error> {
        let context = persistentContainer.viewContext
        do {
            let fetchRequestResult = try context.fetch(request)
            return .success(fetchRequestResult)
        } catch (let error) {
            return .failure(error)
        }
    }
    
    func add<U: NSManagedObject>(entityType: U.Type, mapper: CoreDataModelMapper) {
        let context = persistentContainer.viewContext
        let entity = U(context: context)
        mapper.copyIn(entity: entity)
        saveContext()
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                
            }
        }
    }
}

protocol CoreDataModelMapper {
    
    func copyIn<U: NSManagedObject>(entity: U)
}
