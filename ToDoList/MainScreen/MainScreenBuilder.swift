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
        let navigationController = UINavigationController(rootViewController: MainScreenViewController())
        return navigationController
    }
}
