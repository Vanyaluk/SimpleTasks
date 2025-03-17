//
//  AppCoordinator.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 17.03.2025.
//

import UIKit

/// протокол координатора
/// от него должны наследоваться все координаторы в этом прложении
public protocol FlowCoordinator: AnyObject {
    /// показ экрана
    func start()
}

final class AppCoordinator: FlowCoordinator {
    
    private weak var window: UIWindow?
    
    private let tasksAssembly: TasksAssembly
    
    init(window: UIWindow?, tasksAssembly: TasksAssembly) {
        self.window = window
        self.tasksAssembly = tasksAssembly
    }
    
    func start() {
        window?.rootViewController = tasksAssembly.assemble()
    }
}
