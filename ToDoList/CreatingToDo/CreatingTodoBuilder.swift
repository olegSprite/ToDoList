//
//  CreatingTodoBuilder.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 03.12.2024.
//

import Foundation
import UIKit

final class CreatingTodoBuilder {
    static func build() -> UIViewController {
        let interaction = CreatingTodoInteractor()
        let router = CreatingTodoRouter()
        let presenter = CreatingTodoPresenter(router: router, interactor: interaction)
        let view = CreatingTodoViewController()
        view.presenter = presenter
        interaction.presenter = presenter
        router.presenter = presenter
        presenter.view = view
        return view
    }
}
