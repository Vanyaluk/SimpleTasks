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
    
    func addRowAt(indexPath: IndexPath)
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
    
    private lazy var addTaskButton: UIButton = {
        let button = UIButton()
        let systemImage = UIImage(systemName: "plus")
        let mediumConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium, scale: .default)
        let mediumImage = systemImage?.withConfiguration(mediumConfig)
        let grayImage = mediumImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(grayImage, for: .normal)
        button.backgroundColor = UIColor(red: 83/255, green: 106/255, blue: 245/255, alpha: 1)
        button.layer.cornerRadius = 25
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        return button
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
        
        view.addSubview(addTaskButton)
        addTaskButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(40)
            make.height.width.equalTo(50)
        }
    }
    
    @objc private func addTaskButtonTapped() {
        presenter?.addTaskButtonTapped()
    }
}


extension TasksViewController: TasksViewProtocol {
    func reloadView() {
        tableView.reloadData()
    }
    
    func reloadRowAt(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func addRowAt(indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .fade)
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
