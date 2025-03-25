//
//  LessonsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.04.2024
//

import UIKit

final class TasksAssembly {
    
    private var taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    func assemble() -> TasksViewController {
        let router = TasksRouter()
        let viewController = TasksViewController()
        let presenter = TasksPresenter(
            view: viewController, router: router, taskRepository: taskRepository
        )
        
        
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
