//
//  MainScreenInteractor.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

protocol MainScreenInteractorProtocol: AnyObject {
    func fetchData()
    func todoCompletedToggle(todo: Todo)
    func delete(todo: Todo)
}

final class MainScreenInteractor: MainScreenInteractorProtocol {
    
    // MARK: - Private Properties
    
    private let networkService = NetworkService.shared
    private let coreDataStack = CoreDataStack.shared
    
    // MARK: - Public Properties
    
    var presenter: MainScreenPresenterProtocol?
    
    // MARK: - Lifecycle
    // MARK: - Private Methods
    // MARK: - Public Methods
    
    func fetchData() {
        if UserDefaultService.checkFirstLaunch() {
            UserDefaultService.aplicationLaunchedFirstTime()
            networkService.fetchTodos { result in
                switch result {
                case .success(let todos):
                    self.coreDataStack.saveTodos(todos)
                    DispatchQueue.main.async {
                        self.presenter?.todosIsLoaded(todos: todos)
                    }
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Invalid URL")
                    case .requestFailed(let underlyingError):
                        print("Request failed with error: \(underlyingError)")
                    case .invalidResponse:
                        print("Invalid response from server")
                    case .decodingError(let decodingError):
                        print("Failed to decode JSON: \(decodingError)")
                    }
                }
            }
        }
        self.presenter?.todosIsLoaded(todos: self.coreDataStack.fetchTodos())
    }
    
    func todoCompletedToggle(todo: Todo) {
        coreDataStack.chengeCompleteStatusTodo(id: todo.id)
    }
    
    func delete(todo: Todo) {
        do {
            try coreDataStack.delete(todo: todo)
        } catch {
            print("Не удалось удалить задачу: \(error)")
        }
        self.presenter?.todosIsLoaded(todos: self.coreDataStack.fetchTodos())
    }
    
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}
