//
//  CreatingToDoPresenter.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 03.12.2024.
//

import Foundation

protocol CreatingTodoPresenterProtocol: AnyObject {
    func doneButtonTapped(title: String, todo: String)
}

final class CreatingTodoPresenter: CreatingTodoPresenterProtocol {
    
    // MARK: - Private Properties
    
    private var interactor: CreatingTodoInteractorProtocol
    private var router: CreatingTodoRouterProtocol
    
    // MARK: - Public Properties
    
    weak var view: CreatingToDoViewProtocol?
    weak var parentView: MainScreenViewProtocol?
    
    // MARK: - Init
    
    init(router: CreatingTodoRouterProtocol, interactor: CreatingTodoInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Public Methods
    
    func doneButtonTapped(title: String, todo: String) {
        let todo = Todo(
            id: UUID(),
            title: title,
            todo: todo,
            completed: false,
            date: Date()
        )
        interactor.saveTodo(todo: todo)
        view?.viewReadyForClosing()
        parentView?.fetchNewData()
    }
}
    
