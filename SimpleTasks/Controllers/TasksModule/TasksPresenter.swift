//
//  LessonsPresenter.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.04.2024
//

import UIKit

struct TaskModel {
    var id: String
    var title: String
    var active: Bool
    var checkButtonTapped: () -> ()
}

protocol TasksPresenterProtocol: AnyObject {
    func viewDidLoaded()
    
    var taskModels: [TaskModel] { get }
}

final class TasksPresenter {
    weak var view: TasksViewProtocol?
    var router: TasksRouterInput
    
    var taskModels: [TaskModel] = []

    init(view: TasksViewProtocol, router: TasksRouterInput) {
        self.view = view
        self.router = router
    }
}

extension TasksPresenter: TasksPresenterProtocol {
    
    func viewDidLoaded() {
        let models: [String] = [
            "Первая задача", "Вторая задача",
            "Третья задача", "Четвертая задача", 
            "Пятая задача", "Шестая задача"
        ]
        
        models.forEach { title in
            let id: String = UUID().uuidString
            let model = TaskModel(id: id, title: title, active: true) {
                self.checkButtonTapped(id: id)
            }
            taskModels.append(model)
        }
        
        view?.reloadView()
    }
    
    private func checkButtonTapped(id: String) {
        guard let row = taskModels.firstIndex(where: { $0.id == id }) else {
            print("error /////")
            return
        }
        
        var taskModelsRewrite: [TaskModel] = []
        taskModels.forEach { model in
            var modelCopy = model
            if modelCopy.id == id {
                modelCopy.active.toggle()
            }
            taskModelsRewrite.append(modelCopy)
        }
        
        print(taskModelsRewrite)
        self.taskModels = taskModelsRewrite
        view?.reloadRowAt(indexPath: IndexPath(row: row, section: 0))
    }
}
