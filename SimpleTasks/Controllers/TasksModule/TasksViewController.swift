//
//  LessonsViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.04.2024
//

import UIKit

protocol TasksViewProtocol: AnyObject {
    func reloadView()
    
    func reloadRowAt(indexPath: IndexPath)
}

class TasksViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.id)
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        return view
    }()
    
    var presenter: TasksPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension TasksViewController: TasksViewProtocol {
    func reloadView() {
        tableView.reloadData()
    }
    
    func reloadRowAt(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.taskModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TasksTableViewCell.id, for: indexPath
        ) as? TasksTableViewCell, let viewModel = presenter?.taskModels[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(viewModel: viewModel)
        return cell
    }

}
