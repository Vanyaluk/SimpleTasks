//
//  TasksManager.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 23.03.2025.
//

import Foundation

/// сущность для работы с хранением тасок
protocol TasksManagerProtocol: AnyObject {
    
    /// создание новой модели
    /// - Parameter model: данные новой таски в TaskModel
    func create(model: TaskModel)
    
    /// чтение всех моделей из бд
    /// - Returns: список [TaskModel]
    func read() -> [TaskModel]
    
    /// обновление данных в модели
    /// - Parameter model: данные таски в TaskModel для обновления
    func update(model: TaskModel)
    
    /// удаление модели
    /// - Parameter model: данные таски в TaskModel для удаления
    func delete(model: TaskModel)
}

class TasksManager: TasksManagerProtocol {
    
    private let storage: CoreDataProtocol
    
    init(storage: CoreDataProtocol) {
        self.storage = storage
    }
    
    func create(model: TaskModel) {
        <#code#>
    }
    
    func read() -> [TaskModel] {
        <#code#>
    }
    
    func update(model: TaskModel) {
        <#code#>
    }
    
    func delete(model: TaskModel) {
        <#code#>
    }
    
    
}

