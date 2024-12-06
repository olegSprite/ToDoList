//
//  NetworkService.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 04.12.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}

final class NetworkService {
    
    private let url = URL(string: "https://dummyjson.com/todos")
    
    static let shared = NetworkService()
    
    func fetchTodos(completion: @escaping (Result<[Todo], NetworkError>) -> Void) {
        guard let url else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON-ответ: \(jsonString)")
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedResponse = try decoder.decode(TodoNetworkModel.self, from: data)
                    let todos = decodedResponse.todos.map { todoNetwork -> Todo in
                        Todo(
                            id: UUID(),
                            title: nil,
                            todo: todoNetwork.todo,
                            completed: todoNetwork.completed,
                            date: nil
                        )
                    }
                    completion(.success(todos))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }.resume()
        }
    }
}
