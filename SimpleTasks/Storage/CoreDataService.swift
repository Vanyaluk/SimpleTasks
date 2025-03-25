//
//  CoreDataService.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 18.03.2025.
//

import Foundation
import CoreData

final class CoreDataService: CoreDataProtocol {
    
    private var persistentContainer: NSPersistentContainer
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private lazy var backgroundContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    convenience init() {
        let container = NSPersistentContainer(name: "SimpleTaskCoreData")
        container.loadPersistentStores(completionHandler: { _, _ in })
        self.init(persistentContainer: container)
        
    }
    
    func fetch<Entity: NSManagedObject & EntityNamed, Model>(invertClosure: (Entity) -> Model) -> [Model] {
        var results: [Entity] = []
        viewContext.performAndWait {
            let fetchRequest = NSFetchRequest<Entity>(entityName: Entity.entityName)
            results = (try? fetchRequest.execute()) ?? []
        }
        return results.map(invertClosure)
    }
    
    
    func insert<Model, Entity: NSManagedObject>(models: [Model], convertClosure: @escaping (Model, Entity) -> Void, completion: @escaping () -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            models.forEach { model in
                let entity = Entity(context: self.backgroundContext)
                convertClosure(model, entity)
            }
            try? self.backgroundContext.save()
            completion()
        }
    }
    
    func update<Model: UUIDble, Entity: NSManagedObject & EntityNamed & UUIDble>(
        model: Model, convertClosure: @escaping (Model, Entity) -> Void, completion: @escaping () -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            let fetchRequest = NSFetchRequest<Entity>(entityName: Entity.entityName)
            guard let results = try? fetchRequest.execute(),
                    let entity = results.first(where: { $0.id == model.id }) else { return }
            convertClosure(model, entity)
            try? self.backgroundContext.save()
            completion()
        }
    }
    
    func delete<Entity: NSManagedObject & EntityNamed & UUIDble>(_ type: Entity.Type, id: UUID, completion: @escaping () -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            let fetchRequest = NSFetchRequest<Entity>(entityName: Entity.entityName)
            guard let results = try? fetchRequest.execute(),
                    let entity = results.first(where: { $0.id == id }) else { return }
            self.backgroundContext.delete(entity)
            completion()
        }
    }
    
    func deleteAll<Entity: NSManagedObject & EntityNamed>(_ type: Entity.Type, completion: @escaping () -> Void) {
        backgroundContext.perform {[weak self] in
            guard let self = self else { return }
            let fetchRequest = NSFetchRequest<Entity>(entityName: Entity.entityName)
            if let results = try? fetchRequest.execute() {
                results.forEach { object in
                    self.backgroundContext.delete(object)
                }
            }
            try? viewContext.save()
            completion()
        }
    }
}
