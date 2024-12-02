//
//  Task.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 02.12.2024.
//

import Foundation

// MARK: - TasksModel
struct TasksModel: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int
    let title: String?
    let todo: String
    let completed: Bool
    let userID: Int
    let date: Date?

    enum CodingKeys: String, CodingKey {
        case id, todo, completed, title, date
        case userID = "userId"
    }
}
