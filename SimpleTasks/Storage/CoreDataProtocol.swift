//
//  CoreDataProtocol.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 18.03.2025.
//

import Foundation
import CoreData

protocol EntityNamed {
    static var entityName: String { get }
}

protocol CoreDataProtocol: AnyObject {
        
    /// Извлекает модели из ДБ
    /// - Parameters:
    ///   - storedId: индификатор хранения
    ///   - convertClosure: блок для преобразования ДБ модели в обычную
    func fetch<Entity: NSManagedObject & EntityNamed, Model>(invertClosure: (Entity) -> Model) -> [Model] 
    
    
    /// Вставляет модели в БД
    /// - Parameters:
    ///   - model: модель для сохранения
    ///   - convertClosure: блок для преобразования обычной модели в БД
    func insert<Model, Entity: NSManagedObject>(models: [Model], convertClosure: @escaping (Model, Entity) -> Void, completion: @escaping () -> Void)
    
    
    /// Обновляет модель в БД
    /// - Parameters:
    ///   - model: модель для обновления
    ///   - convertClosure: блок для преобразования обычной модели в БД
    func update<Model: UUIDble, Entity: NSManagedObject & EntityNamed & UUIDble>(model: Model, convertClosure: @escaping (Model, Entity) -> Void, completion: @escaping () -> Void)
    
    
    /// Удаляет модель в БД
    /// - Parameters:
    ///   - model: модель для удаления
    ///   - convertClosure: блок для преобразования обычной модели в БД
    func delete<Entity: NSManagedObject & EntityNamed & UUIDble>(_ type: Entity.Type, id: UUID, completion: @escaping () -> Void)
    
    
    /// Удаляет модели из БД
    /// - Parameters:
    ///   - models: модели для сохранения
    ///   - convertClosure: блок для преобразования ДБ модели в обычную
    func deleteAll<Entity: NSManagedObject & EntityNamed>(_ type: Entity.Type, completion: @escaping () -> Void)
}

