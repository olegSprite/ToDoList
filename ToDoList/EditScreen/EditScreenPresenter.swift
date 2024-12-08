//
//  EditScreenPresenter.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 08.12.2024.
//

import Foundation

protocol EditScreenPresenterProtocol: AnyObject {
    func saveEditToto(todo: Todo, newTitle: String, newDescription: String)
    func todoSaving()
}

final class EditScreenPresenter: EditScreenPresenterProtocol {
    
    private var iteractor: EditScreenIteractorProtocol?
    private var router: EditScreenRouterProtocol?
    
    weak var view: EditScreenViewControllerProtocol?
    weak var parentView: MainScreenViewProtocol?
    
    init(iteractor: EditScreenIteractorProtocol? = nil, router: EditScreenRouterProtocol? = nil) {
        self.iteractor = iteractor
        self.router = router
    }
    func saveEditToto(todo: Todo, newTitle: String, newDescription: String) {
        iteractor?.saveEditToto(todo: todo, newTitle: newTitle, newDescription: newDescription)
    }
    
    func todoSaving() {
        view?.closeScreen()
        parentView?.fetchNewData()
    }
}
