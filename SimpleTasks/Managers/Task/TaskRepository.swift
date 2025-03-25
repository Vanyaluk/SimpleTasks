//
//  TasksManager.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 23.03.2025.
//

import Foundation
import CoreData

/// сущность для работы с хранением тасок
protocol TaskRepositoryProtocol: AnyObject {
    
    /// создание новой модели
    func insertEmptyTask(completion: @escaping () -> Void)
    
    /// чтение всех моделей из бд
    /// - Parameters:
    ///   - checkButtonTapped: замыкание от первой кнопки
    ///   - changeTitle: замыкание от второй кнопки
    /// - Returns: список [TaskModel]
    func fetch(checkButtonTapped: @escaping (UUID) -> Void, changeTitle: @escaping (UUID, String) -> Void) -> [TaskModel]
    
    /// обновление данных в модели
    /// - Parameter model: данные таски в TaskModel для обновления
    func update(model: TaskModel, completion: @escaping () -> Void)
    
    /// удаление модели
    /// - Parameter id: id таски
    func delete(id: UUID, completion: @escaping () -> Void)
}

class TaskRepository: TaskRepositoryProtocol {
    
    private let storage: CoreDataProtocol
    
    init(storage: CoreDataProtocol) {
        self.storage = storage
    }
    
    private let convertClosure: (TaskModel, TaskEntity) -> Void = { model, entity in
        entity.id = model.id
        entity.title = model.title
        entity.isDone = model.isDone
        entity.date = model.date
        entity.row = model.row
    }
    
    func insertEmptyTask(completion: @escaping () -> Void) {
        let model = TaskModel(
            id: UUID(), title: "", isDone: false,
            date: Date(), row: 0, checkButtonTapped: {},
            changeTitle: {_ in}
        )
        
        storage.insert(models: [model], convertClosure: convertClosure, completion: completion)
    }
    
    func fetch(checkButtonTapped: @escaping (UUID) -> Void,
               changeTitle: @escaping (UUID, String) -> Void) -> [TaskModel] {
        
        let invertedClosure: (TaskEntity) -> TaskModel = { entity in
            guard let title = entity.title, let date = entity.date, let id = entity.id else {
                return TaskModel.getMockModel()
            }
            let model = TaskModel(id: entity.id, title: title, isDone: entity.isDone, date: date, row: entity.row) {
                checkButtonTapped(id)
            } changeTitle: { title in
                changeTitle(id, title)
            }
            return model
        }
        
        return storage.fetch(invertClosure: invertedClosure)
    }
    
    func update(model: TaskModel, completion: @escaping () -> Void) {
        storage.update(model: model, convertClosure: convertClosure, completion: completion)
    }
    
    func delete(id: UUID, completion: @escaping () -> Void) {
        storage.delete(TaskEntity.self, id: id, completion: completion)
    }
    
}

