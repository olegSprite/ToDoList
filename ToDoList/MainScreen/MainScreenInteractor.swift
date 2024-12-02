//
//  MainScreenInteractor.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

protocol MainScreenInteractorProtocol: AnyObject {
    func fetchData() -> TasksModel
}

final class MainScreenInteractor: MainScreenInteractorProtocol {
    
    // MARK: - Private Properties
    // MARK: - Public Properties
    
    var presenter: MainScreenPresenterProtocol?
    
    // MARK: - Lifecycle
    // MARK: - Private Methods
    // MARK: - Public Methods
    
    func fetchData() -> TasksModel {
        let task = TasksModel(todos: [
            Todo(id: 100, title: "Тест", todo: "Тест Тест Тест Тест ТестТестТест", completed: true, userID: 1, date: Date()),
            Todo(id: 100, title: "Тест", todo: "Тест Тест Тест Тест ТестТестТест", completed: true, userID: 1, date: Date()),
            Todo(id: 100, title: "Тест", todo: "Тест Тест Тест Тест ТестТестТест", completed: true, userID: 1, date: Date()),
            Todo(id: 100, title: "Тест", todo: "Тест Тест Тест Тест ТестТестТест", completed: false, userID: 1, date: Date()),
            Todo(id: 100, title: "Тест", todo: "Тест Тест Тест Тест ТестТестТест", completed: false, userID: 1, date: Date()),
            Todo(id: 100, title: "Тест", todo: "Тест Тест Тест Тест ТестТестТест", completed: false, userID: 1, date: Date())
        ],
                              total: 1,
                              skip: 1,
                              limit: 1)
        return task
    }
    
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}
