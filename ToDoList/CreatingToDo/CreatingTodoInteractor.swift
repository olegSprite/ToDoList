//
//  CreatingTodoInteractor.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 03.12.2024.
//

import Foundation

protocol CreatingTodoInteractorProtocol {
    func saveTodo(todo: Todo)
}

final class CreatingTodoInteractor: CreatingTodoInteractorProtocol {
    
    // MARK: - Private Properties
    
    private let coreDataStack = CoreDataStack.shared
    
    // MARK: - Public Properties
    
    var presenter: CreatingTodoPresenterProtocol?
    
    // MARK: - Public Methods
    
    func saveTodo(todo: Todo) {
        coreDataStack.saveTodo(todo)
    }
}
