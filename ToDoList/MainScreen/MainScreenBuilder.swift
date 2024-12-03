//
//  MainScreenBuilder.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation
import UIKit

final class MainScreenBuilder {
    static func build() -> UIViewController {
        let interaction = MainScreenInteractor()
        let router = MainScreenRouter()
        let presenter = MainScreenPresenter(router: router, interactor: interaction)
        let view = MainScreenViewController()
        view.presenter = presenter
        interaction.presenter = presenter
        router.presenter = presenter
        router.view = view
        presenter.view = view
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}
