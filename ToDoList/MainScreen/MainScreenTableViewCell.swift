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
    
    private let checkmarkButton = UIButton()
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
        contentView.backgroundColor = UIColor(named: "Black")
        setupChekmarkImageView()
        setupTitleLable()
        setupDateLable()
        setupDescriptionLable()
    }
    
    private func setupChekmarkImageView() {
        guard let todo else { return }
        if todo.completed {
            checkmarkButton.setImage(.init(systemName: "checkmark.circle"), for: .normal)
            checkmarkButton.tintColor = UIColor(named: "Yellow")
        } else {
            checkmarkButton.setImage(.init(systemName: "circle"), for: .normal)
            checkmarkButton.tintColor = UIColor(named: "Gray")
        }
        checkmarkButton.addTarget(self, action: #selector(checkmarkButtonTapped), for: .touchUpInside)
        contentView.addSubview(checkmarkButton)
        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkmarkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 48),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupTitleLable() {
        guard let todo else { return }
        titleLabel.text = todo.title
        if todo.completed {
            titleLabel.textColor = UIColor(named: "Gray")
        } else {
            titleLabel.textColor = UIColor(named: "White")
        }
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: checkmarkButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 8)
        ])
    }
    
    private func setupDateLable() {
        guard let todo else { return }
        if let date = todo.date {
            dateLable.text = date.formattedToAppFormat()
        }
        dateLable.textColor = UIColor(named: "Gray")
        dateLable.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        contentView.addSubview(dateLable)
        dateLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLable.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 8),
            dateLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupDescriptionLable() {
        guard let todo else { return }
        descriptionLabel.text = todo.todo
        if todo.completed {
            descriptionLabel.textColor = UIColor(named: "Gray")
        } else {
            descriptionLabel.textColor = UIColor(named: "White")
        }
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.numberOfLines = 2
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.bottomAnchor.constraint(equalTo: dateLable.topAnchor, constant: -6)
        ])
    }
    
    // MARK: - Public Methods
    // MARK: - Private Actions
    
    @objc private func checkmarkButtonTapped() {
        
    }
    
    // MARK: - Public Actions
    
}
