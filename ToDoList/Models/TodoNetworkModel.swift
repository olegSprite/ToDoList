//
//  TodoNetworkModel.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 04.12.2024.
//

import Foundation

struct TodoNetworkModel: Codable {
    let todos: [TodoNetwork]
    let total, skip, limit: Int
}

struct TodoNetwork: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
}

