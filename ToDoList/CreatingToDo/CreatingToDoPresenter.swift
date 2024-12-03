//
//  CreatingToDoPresenter.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 03.12.2024.
//

import Foundation

protocol CreatingTodoPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

final class CreatingTodoPresenter: CreatingTodoPresenterProtocol {
    
    // MARK: - Private Properties
    
    private var interactor: CreatingTodoInteractorProtocol
    private var router: CreatingTodoRouterProtocol
    
    // MARK: - Public Properties
    
    weak var view: CreatingToDoViewProtocol?
    
    // MARK: - Init
    
    init(router: CreatingTodoRouterProtocol, interactor: CreatingTodoInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Lifecycle
    // MARK: - Private Methods
    // MARK: - Public Methods
    
    func viewDidLoaded() {
        
    }
    
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}
    
