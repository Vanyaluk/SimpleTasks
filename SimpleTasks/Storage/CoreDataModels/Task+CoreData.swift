//
//  Task+CoreData.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 18.03.2025.
//

import Foundation
import CoreData

@objc(Task)
public class TaskEntity: NSManagedObject {}

extension TaskEntity {
    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var title: String?
}

extension TaskEntity: EntityNamed {
    static var entityName: String {
        return "TaskEntity"
    }
}
