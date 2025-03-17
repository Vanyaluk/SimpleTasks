//
//  LessonsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.04.2024
//

import UIKit

final class TasksAssembly {
    
    func assemble() -> TasksViewController {
        let router = TasksRouter()
        let viewController = TasksViewController()
        let presenter = TasksPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
