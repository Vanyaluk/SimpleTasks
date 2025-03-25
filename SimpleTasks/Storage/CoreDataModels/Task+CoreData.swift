//
//  Task+CoreData.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 18.03.2025.
//

import Foundation
import CoreData

@objc(TaskEntity)
public class TaskEntity: NSManagedObject {}

extension TaskEntity: UUIDble {
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var date: Date?
    @NSManaged public var row: Int16
}

extension TaskEntity: EntityNamed {
    static var entityName: String {
        return "TaskEntity"
    }
}

protocol UUIDble {
    var id: UUID? { get set }
}
