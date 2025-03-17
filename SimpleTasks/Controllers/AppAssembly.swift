//
//  AppAssembly.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 17.03.2025.
//

import UIKit

final class AppAssembly {
    static func assemble(window: UIWindow?) -> AppCoordinator {
        
        let tasksAssembly = TasksAssembly()
        
        let appCoordinator = AppCoordinator(
            window: window,
            tasksAssembly: tasksAssembly
        )
        
        return appCoordinator
    }
}
