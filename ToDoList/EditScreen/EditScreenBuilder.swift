//
//  EditScreenBuilder.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 08.12.2024.
//

import Foundation
import UIKit

final class EditScreenBuilder {
    static func build(for todo: Todo, from view: MainScreenViewProtocol) -> UIViewController {
        let vc = EditScreenViewController(todo: todo)
        let iteractor = EditScreenIteractor()
        let router = EditScreenRouter()
        let presenter = EditScreenPresenter(iteractor: iteractor, router: router)
        presenter.view = vc
        presenter.parentView = view
        vc.presenterEditScreen = presenter
        iteractor.presenter = presenter
        return vc
    }
}
