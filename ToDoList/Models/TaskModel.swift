//
//  Task.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

struct Todo: Codable, Equatable {
    let id: UUID
    let title: String?
    let todo: String
    var completed: Bool
    let date: Date?
}
