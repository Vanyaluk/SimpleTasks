//
//  TaskModel.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 23.03.2025.
//

import Foundation

struct TaskModel {
    var id: UUID
    var title: String
    var isDone: Bool
    var date: Date
    var checkButtonTapped: () -> ()
    var changeTitle: (String) -> ()
    
    static func getMockModel() -> Self {
        return TaskModel(id: UUID(), title: "Test", isDone: false, date: Date(), checkButtonTapped: {}, changeTitle: {_ in })
    }
}
