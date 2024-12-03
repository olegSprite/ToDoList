//
//  MainScreenPresenter.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    var tasks: TasksModel? { get }
    func viewDidLoaded()
    func newTaskButtonTapped()
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    
    // MARK: - Private Properties
    
    private var router: MainScreenRouterProtocol
    private var interactor: MainScreenInteractorProtocol
    
    // MARK: - Public Properties
    
    weak var view: MainScreenViewProtocol?
    var tasks: TasksModel? = nil
    
    //MARK: - Init
    
    init(router: MainScreenRouterProtocol, interactor: MainScreenInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Lifecycle
    // MARK: - Private Methods
    // MARK: - Public Methods
    
    func viewDidLoaded() {
        self.tasks = interactor.fetchData()
        view?.reloadData()
    }
    
    func newTaskButtonTapped() {
        router.openCreatingTodoScreen()
    }
    
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}
