//
//  EditScreenIteractor.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 08.12.2024.
//

import Foundation

protocol EditScreenIteractorProtocol: AnyObject {
    func saveEditToto(todo: Todo, newTitle: String, newDescription: String)
}

final class EditScreenIteractor: EditScreenIteractorProtocol {
    
    private let coreDataStack = CoreDataStack.shared
    
    var presenter: EditScreenPresenterProtocol?
    
    func saveEditToto(todo: Todo, newTitle: String, newDescription: String) {
        do {
            try coreDataStack.editTodo(todo: todo, newTitile: newTitle, newDescription: newDescription)
        } catch {
            print("Не удалось обновить задачу: \(error)")
        }
        presenter?.todoSaving()
    }
}
