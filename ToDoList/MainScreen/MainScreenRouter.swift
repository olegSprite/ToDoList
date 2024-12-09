//
//  MainScreenRouter.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

protocol MainScreenRouterProtocol: AnyObject {
    func openCreatingTodoScreen()
    func openEditScreen(todo: Todo)
}

final class MainScreenRouter: MainScreenRouterProtocol {
    
    // MARK: - Public Properties
    
    weak var view: MainScreenViewController?
    var presenter: MainScreenPresenterProtocol?
    
    // MARK: - Public Methods
    
    func openCreatingTodoScreen() {
        guard let view else { return }
        let vc = CreatingTodoBuilder.build(from: view)
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openEditScreen(todo: Todo) {
        guard let view else { return }
        let vc = EditScreenBuilder.build(for: todo, from: view)
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }    
}
