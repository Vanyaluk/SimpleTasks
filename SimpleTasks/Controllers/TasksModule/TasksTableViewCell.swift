//
//  TasksTableViewCell.swift
//  SimpleTasks
//
//  Created by Иван Лукъянычев on 17.03.2025.
//

import UIKit
import SnapKit

final class TasksTableViewCellView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.text = "test"
        return label
    }()
    
    private lazy var activeTaskImage: UIImage? = {
        let systemImage = UIImage(systemName: "app")
        let mediumConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .default)
        let mediumImage = systemImage?.withConfiguration(mediumConfig)
        let grayImage = mediumImage?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        return grayImage
    }()
    
    private lazy var doneTaskImage: UIImage? = {
        let systemImage = UIImage(systemName: "xmark.app.fill")
        let mediumConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .default)
        let mediumImage = systemImage?.withConfiguration(mediumConfig)
        let grayImage = mediumImage?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        return grayImage
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setImage(activeTaskImage, for: .normal)
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var model: TaskModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let cellHeight = 40
        
        snp.makeConstraints { make in
            make.height.equalTo(cellHeight)
        }
        
        addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.height.equalTo(cellHeight)
            make.width.equalTo(35)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkButton.snp.trailing)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(viewModel: TaskModel) {
        model = viewModel
        guard let model = self.model else { return }
        titleLabel.text = model.title
        checkButton.setImage(model.active ? activeTaskImage : doneTaskImage, for: .normal)
        titleLabel.textColor = model.active ? .label : .lightGray
    }
    
    @objc private func checkButtonTapped() {
        model?.checkButtonTapped()
    }
}

final class TasksTableViewCell: UITableViewCell {
    private lazy var view = TasksTableViewCellView()
    
    static let id = "TasksTableViewCellID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: TaskModel) {
        view.configure(viewModel: viewModel)
    }
}
