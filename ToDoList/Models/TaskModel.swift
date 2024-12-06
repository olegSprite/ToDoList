//
//  Task.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

struct Todo: Codable {
    let id: UUID
    let title: String?
    let todo: String
    let completed: Bool
    let date: Date?
}
