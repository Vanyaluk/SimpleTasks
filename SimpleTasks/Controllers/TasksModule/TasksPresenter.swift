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
    private var taskRepository: TaskRepositoryProtocol
    
    var taskModels: [TaskModel] = []

    init(view: TasksViewProtocol?, router: TasksRouterInput, taskRepository: TaskRepositoryProtocol) {
        self.view = view
        self.router = router
        self.taskRepository = taskRepository
    }
    
    private func fetchTaskStorage() {
        taskModels = taskRepository.fetch(
            checkButtonTapped: checkButtonTapped(id:),
            changeTitle: changeTitle(id: title:)
        )
    }
}

extension TasksPresenter: TasksPresenterProtocol {
    
    func viewDidLoaded() {
        fetchTaskStorage()
        view?.reloadView()
    }
    
    func addTaskButtonTapped() {
        taskRepository.insertEmptyTask { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.fetchTaskStorage()
                self.view?.addRowAt(indexPath: IndexPath(row: self.taskModels.count - 1, section: 0))
            }
        }
    }
    
    private func changeTitle(id: UUID, title: String) {
        guard var model = taskModels.first(where: {$0.id == id}) else { return }
        model.title = title
        taskRepository.update(model: model) { [weak self] in
            DispatchQueue.main.async {
                self?.fetchTaskStorage()
            }
        }
    }
    
    private func checkButtonTapped(id: UUID) {
        guard var model = taskModels.first(where: {$0.id == id}),
                let row = taskModels.firstIndex(where: { $0.id == id }) else { return }
        model.isDone.toggle()
        taskRepository.update(model: model) { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.fetchTaskStorage()
                self.view?.reloadRowAt(indexPath: IndexPath(row: row, section: 0))
            }
        }
    }
}


