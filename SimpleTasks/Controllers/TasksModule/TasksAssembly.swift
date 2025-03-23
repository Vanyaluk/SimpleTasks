//
//  LessonsAssembly.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.04.2024
//

import UIKit

final class TasksAssembly {
    
    private var coreDataService: CoreDataProtocol
    
    init(coreDataService: CoreDataProtocol) {
        self.coreDataService = coreDataService
    }
    
    func assemble() -> TasksViewController {
        let router = TasksRouter()
        let viewController = TasksViewController()
        let presenter = TasksPresenter(
            view: viewController,
            router: router,
            coreDataService: coreDataService
        )
        
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
