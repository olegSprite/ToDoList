//
//  EditScreenViewController.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 08.12.2024.
//

import UIKit

protocol EditScreenViewControllerProtocol: AnyObject {
    func closeScreen()
}

final class EditScreenViewController: CreatingTodoViewController, EditScreenViewControllerProtocol {
    
    // MARK: - Private Properties
    
    private var todo: Todo?
    
    // MARK: - Public Properties
    
    var presenterEditScreen: EditScreenPresenterProtocol?
    
    // MARK: - Init
    
    init(todo: Todo) {
        super.init(nibName: nil, bundle: nil)
        self.todo = todo
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let todo else { return }
        self.titleTextField.text = todo.title
        self.descriptionTextView.text = todo.todo
        self.dateLabel.text = todo.date?.formattedToAppFormat()
    }
    
    // MARK: - Private Methods
    
    override func doneButtonTapped() {
        guard let todo else { return }
        presenterEditScreen?.saveEditToto(todo: todo, newTitle: self.titleTextField.text ?? "", newDescription: self.descriptionTextView.text)
    }
    
    // MARK: - Public Methods
    
    func closeScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}
