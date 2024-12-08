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
    
    var presenter: MainScreenPresenterProtocol?
    
    // MARK: - Init
    
    init(todo: Todo, presenter: MainScreenPresenterProtocol?) {
        super.init(style: .default, reuseIdentifier: nil)
        self.presenter = presenter
        self.todo = todo
        setupCell()
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)
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
    
    private func toggleCheckmarkButton() {
        guard let todo else { return }
        if todo.completed {
            checkmarkButton.setImage(.init(systemName: "circle"), for: .normal)
            checkmarkButton.tintColor = UIColor(named: "Gray")
            titleLabel.textColor = UIColor(named: "White")
            descriptionLabel.textColor = UIColor(named: "White")
        } else {
            checkmarkButton.setImage(.init(systemName: "checkmark.circle"), for: .normal)
            checkmarkButton.tintColor = UIColor(named: "Yellow")
            titleLabel.textColor = UIColor(named: "Gray")
            descriptionLabel.textColor = UIColor(named: "Gray")
        }
        self.todo?.completed.toggle()
    }
    
    // MARK: - Public Methods
    // MARK: - Private Actions
    
    @objc private func checkmarkButtonTapped() {
        toggleCheckmarkButton()
        presenter?.todoCompletedToggle(todo: self.todo!)
    }
    
    // MARK: - Public Actions
    
}

// MARK: - UIContextMenuInteractionDelegate

extension MainScreenTableViewCell: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: { [weak self] in
            guard let self = self else { return UIViewController() }
            guard let todo else { return UIViewController()}
            return self.createPreviewView(todo: todo)
        }) { _ in
            let editAction = UIAction(
                title: "Редактировать",
                image: UIImage(systemName: "square.and.pencil")
            ) { _ in
                guard let todo = self.todo else { return }
                self.presenter?.editTodo(todo: todo)
            }
            let shareAction = UIAction(
                title: "Поделиться",
                image: UIImage(systemName: "square.and.arrow.up")
            ) { _ in
                print("Поделиться задачей")
            }
            let deleteAction = UIAction(
                title: "Удалить",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                guard let todo = self.todo else { return }
                self.presenter?.delete(todo: todo)
            }
            return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
        }
    }
    
    private func createPreviewView(todo: Todo) -> UIViewController {
        let previewController = UIViewController()
        previewController.view.backgroundColor = UIColor(named: "Gray")
        previewController.view.clipsToBounds = true
        previewController.view.layer.cornerRadius = 12
        let titleLabel = UILabel()
        let descriptionLable = UILabel()
        let dateLabel = UILabel()
        titleLabel.text = todo.title
        descriptionLable.text = todo.todo
        dateLabel.text = todo.date?.formattedToAppFormat()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        descriptionLable.font = UIFont.systemFont(ofSize: 12)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor(named: "White")
        descriptionLable.textColor = UIColor(named: "White")
        dateLabel.textColor = UIColor(named: "White")
        descriptionLable.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        previewController.view.addSubview(titleLabel)
        previewController.view.addSubview(descriptionLable)
        previewController.view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: previewController.view.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: previewController.view.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: previewController.view.trailingAnchor, constant: -16),
            descriptionLable.leadingAnchor.constraint(equalTo: previewController.view.leadingAnchor, constant: 16),
            descriptionLable.trailingAnchor.constraint(equalTo: previewController.view.trailingAnchor, constant: -16),
            descriptionLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: previewController.view.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: previewController.view.bottomAnchor, constant: -12)
        ])
        let maxWidth: CGFloat = UIScreen.main.bounds.width - 40
        let size = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let boundingRect = todo.todo.boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: [.font: descriptionLable.font!],
            context: nil
        )
        previewController.preferredContentSize = CGSize(width: maxWidth, height: boundingRect.height + 74)
        return previewController
    }
}
