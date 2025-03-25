//
//  TaskModel.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 23.03.2025.
//

import Foundation

struct TaskModel: UUIDble {
    var id: UUID?
    var title: String
    var isDone: Bool
    var date: Date
    var row: Int16
    var checkButtonTapped: () -> ()
    var changeTitle: (String) -> ()
    
    static func getMockModel() -> Self {
        return TaskModel(id: UUID(), title: "Mocked model because error", isDone: false, date: Date(), row: 0, checkButtonTapped: {}, changeTitle: {_ in })
    }
}
