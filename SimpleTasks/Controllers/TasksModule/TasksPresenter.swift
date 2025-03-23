//
//  LessonsPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.04.2024
//

import UIKit



protocol TasksPresenterProtocol: AnyObject {
    var taskModels: [TaskModel] { get }
    
    func viewDidLoaded()
    
    func addTaskButtonTapped()
}

final class TasksPresenter {
    
    weak var view: TasksViewProtocol?
    var router: TasksRouterInput
    private var coreDataService: CoreDataProtocol
    
    var taskModels: [TaskModel] = []

    init(view: TasksViewProtocol?, router: TasksRouterInput, coreDataService: CoreDataProtocol) {
        self.view = view
        self.router = router
        self.coreDataService = coreDataService
    }
}

extension TasksPresenter: TasksPresenterProtocol {
    
    func viewDidLoaded() {
        let convertClosure: (TaskEntity) -> TaskModel = { entity in
            guard let id = entity.id,
                    let title = entity.title,
                    let date = entity.date else {
                return TaskModel.getMockModel()
            }
            
            let model = TaskModel(id: id, title: title, isDone: entity.isDone, date: date) {
                self.checkButtonTapped(id: id)
            } changeTitle: { newTitle in
                self.changeTitle(id: id, title: newTitle)
            }

            return model
        }
        
        taskModels = coreDataService.fetch(convertClosure: convertClosure)
        
        view?.reloadView()
    }
    
    func addTaskButtonTapped() {
        let id: UUID = UUID()
        let model = TaskModel(id: id, title: "", isDone: true, date: Date()) {
            self.checkButtonTapped(id: id)
        } changeTitle: { newTitle in
            self.changeTitle(id: id, title: newTitle)
        }
        taskModels.append(model)
        view?.addRowAt(indexPath: IndexPath(row: taskModels.count - 1, section: 0))
    }
    
    private func changeTitle(id: UUID, title: String) {
        var taskModelsRewrite: [TaskModel] = []
        taskModels.forEach { model in
            var modelCopy = model
            if modelCopy.id == id {
                modelCopy.title = title
            }
            taskModelsRewrite.append(modelCopy)
        }
        
        self.taskModels = taskModelsRewrite
    }
    
    private func checkButtonTapped(id: UUID) {
        guard let row = taskModels.firstIndex(where: { $0.id == id }) else {
            print("error /////")
            return
        }
        
        var taskModelsRewrite: [TaskModel] = []
        taskModels.forEach { model in
            var modelCopy = model
            if modelCopy.id == id {
                modelCopy.isDone.toggle()
            }
            taskModelsRewrite.append(modelCopy)
        }
        
        self.taskModels = taskModelsRewrite
        view?.reloadRowAt(indexPath: IndexPath(row: row, section: 0))
        print(row)
    }
}


