//
//  MainScreenPresenter.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    
    var tasks: [Todo]? { get }
    var fillteredTasks: [Todo]? { get }
    func viewDidLoaded()
    func newTaskButtonTapped()
    func todosIsLoaded(todos: [Todo])
    func loadTodosFromCoreData()
    func todoCompletedToggle(todo: Todo)
    func editTodo(todo: Todo)
    func delete(todo: Todo)
    func clearCearch()
    func filterTodos(by searchText: String?)
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    
    // MARK: - Private Properties
    
    private var router: MainScreenRouterProtocol
    private var interactor: MainScreenInteractorProtocol
    
    // MARK: - Public Properties
    
    weak var view: MainScreenViewProtocol?
    var tasks: [Todo]? = nil
    var fillteredTasks: [Todo]? = nil
    
    //MARK: - Init
    
    init(router: MainScreenRouterProtocol, interactor: MainScreenInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }

    // MARK: - Public Methods
    
    func viewDidLoaded() {
        interactor.fetchData()
    }
    
    func newTaskButtonTapped() {
        router.openCreatingTodoScreen()
    }
    
    func todosIsLoaded(todos: [Todo]) {
        self.tasks = todos
        self.fillteredTasks = todos
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
    
    func clearCearch() {
        self.fillteredTasks = self.tasks
        view?.reloadData()
    }
    
    func filterTodos(by searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            self.fillteredTasks = self.tasks
            view?.reloadData()
            return
        }
        self.fillteredTasks = self.tasks?.filter { todo in
            (todo.title?.lowercased().contains(searchText.lowercased()) ?? false) ||
            (todo.todo.lowercased().contains(searchText.lowercased()))
        }
        view?.reloadData()
    }
}
