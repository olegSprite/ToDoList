//
//  CreatingToDoView.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 03.12.2024.
//

import UIKit

protocol CreatingToDoViewProtocol: AnyObject {
    
}

final class CreatingTodoViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let titleTextField = UITextField()
    private let dateLabel = UILabel()
    private let descriptionTextView = UITextView()
    
    // MARK: - Public Properties
    
    var presenter: CreatingTodoPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "Black")
        self.hideKeyboardWhenTappedAround()
        setupNavBar()
        setupTitleTextView()
        setupDateLabel()
        setupDescriptionTextView()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupTitleTextView() {
        titleTextField.font = UIFont.boldSystemFont(ofSize: 34)
        titleTextField.placeholder = "Заголовок"
        titleTextField.textColor = UIColor(named: "White")
        titleTextField.backgroundColor = .clear
        titleTextField.borderStyle = .none
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.text = Date().formattedToAppFormat()
        dateLabel.textColor = UIColor(named: "Gray")
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupDescriptionTextView() {
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.textColor = UIColor(named: "White")
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    // MARK: - Private Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Public Actions
    
}

// MARK: - CreatingToDoViewProtocol

extension CreatingTodoViewController: CreatingToDoViewProtocol {
    
}