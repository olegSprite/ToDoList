//
//  MainScreenTableViewCell.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation
import UIKit

final class MainScreenTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let checkmarkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLable = UILabel()
    private var todo: Todo?
    
    // MARK: - Public Properties
    // MARK: - Init
    
    init(todo: Todo) {
        super.init(style: .default, reuseIdentifier: nil)
        self.todo = todo
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCell() {
        setupChekmarkImageView()
    }
    
    private func setupChekmarkImageView() {
        guard let todo else { return }
        if todo.completed {
            checkmarkImageView.image = .init(systemName: "checkmark.circle")
            checkmarkImageView.tintColor = .yellow
        } else {
            checkmarkImageView.image = .init(systemName: "circle")
            checkmarkImageView.tintColor = .gray
        }
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkmarkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkmarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Public Methods
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}
