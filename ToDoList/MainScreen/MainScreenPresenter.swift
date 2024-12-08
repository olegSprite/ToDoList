//
//  MainScreenPresenter.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var tasks: [Todo]? { get }
    func viewDidLoaded()
    func newTaskButtonTapped()
    func todosIsLoaded(todos: [Todo])
    func loadTodosFromCoreData()
    func todoCompletedToggle(todo: Todo)
    func editTodo(todo: Todo)
    func delete(todo: Todo)
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    
    // MARK: - Private Properties
    
    private var router: MainScreenRouterProtocol
    private var interactor: MainScreenInteractorProtocol
    
    // MARK: - Public Properties
    
    weak var view: MainScreenViewProtocol?
    var tasks: [Todo]? = nil
    
    //MARK: - Init
    
    init(router: MainScreenRouterProtocol, interactor: MainScreenInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Lifecycle
    // MARK: - Private Methods
    // MARK: - Public Methods
    
    func viewDidLoaded() {
        interactor.fetchData()
    }
    
    func newTaskButtonTapped() {
        router.openCreatingTodoScreen()
    }
    
    func todosIsLoaded(todos: [Todo]) {
        self.tasks = todos
        view?.reloadData()
    }
    
    func loadTodosFromCoreData() {
        interactor.fetchData()
    }
    
    func todoCompletedToggle(todo: Todo) {
        interactor.todoCompletedToggle(todo: todo)
    }
    
    func editTodo(todo: Todo) {
        router.openEditScreen(todo: todo)
    }
    
    func delete(todo: Todo) {
        interactor.delete(todo: todo)
    }

    
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}
