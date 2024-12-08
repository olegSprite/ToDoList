//
//  CoreDataStack.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 04.12.2024.
//

import CoreData
import UIKit

class CoreDataStack {
    
    static let shared = CoreDataStack()
    private let appDelegate: AppDelegate
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        self.appDelegate = appDelegate
    }
    
    func saveTodo(_ todo: Todo) {
        let backgroundContext = appDelegate.persistentContainer.newBackgroundContext()
        let todoEntity = TodoEntity(context: backgroundContext)
        todoEntity.id = todo.id
        todoEntity.title = todo.title
        todoEntity.todo = todo.todo
        todoEntity.completed = todo.completed
        todoEntity.date = todo.date
        do {
            try backgroundContext.save()
        } catch {
            print("Ошибка при сохранении todo: \(error.localizedDescription)")
        }
    }
    
    func saveTodos(_ todos: [Todo]) {
        let backgroundContext = appDelegate.persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            for todo in todos {
                let todoEntity = TodoEntity(context: backgroundContext)
                todoEntity.id = UUID()
                todoEntity.todo = todo.todo
                todoEntity.completed = todo.completed
                todoEntity.title = nil
                todoEntity.date = nil
            }
            do {
                try backgroundContext.save()
                print("Данные успешно сохранены в Core Data")
            } catch {
                print("Ошибка сохранения данных: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTodos() -> [Todo] {
        let backgroundContext = appDelegate.persistentContainer.newBackgroundContext()
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            let results = try backgroundContext.fetch(fetchRequest)
            let todos: [Todo] = results.map { entity in
                Todo(
                    id: entity.id ?? UUID(),
                    title: entity.title,
                    todo: entity.todo ?? "Нет данных",
                    completed: entity.completed,
                    date: entity.date
                )
            }
            return todos
        } catch {
            print("Ошибка загрузки данных: \(error)")
            return []
        }
    }
    
    func chengeCompleteStatusTodo(id: UUID) {
        let backgroundContext = appDelegate.persistentContainer.newBackgroundContext()
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            let results = try backgroundContext.fetch(fetchRequest)
            let todoEntity = results.first { $0.id == id }
            todoEntity?.completed.toggle()
            try backgroundContext.save()
        } catch {
            print("Ошибка изменения статуса задачи: \(error)")
        }
    }
    
    func editTodo(todo: Todo, newTitile: String, newDescription: String) throws {
        let backgroundContext = appDelegate.persistentContainer.newBackgroundContext()
        do {
            let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", todo.id as CVarArg)
            fetchRequest.fetchLimit = 1
            let results = try backgroundContext.fetch(fetchRequest)
            guard let todo = results.first else {
                throw NSError(domain: "TodoError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Todo с указанным UUID не найден"])
            }
            todo.title = newTitile
            todo.todo = newDescription
            try backgroundContext.save()
            print("Todo успешно обновлено!")
        } catch {
            print("Ошибка при редактировании Todo: \(error.localizedDescription)")
            throw error
        }
    }
    
    func delete(todo: Todo) throws {
        let backgroundContext = appDelegate.persistentContainer.newBackgroundContext()
        do {
            let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", todo.id as CVarArg)
            fetchRequest.fetchLimit = 1
            let results = try backgroundContext.fetch(fetchRequest)
            guard let todoToDelete = results.first else {
                throw NSError(domain: "TodoError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Todo с указанным UUID не найден"])
            }
            backgroundContext.delete(todoToDelete)
            try backgroundContext.save()
            print("Todo успешно удалён!")
        } catch {
            print("Ошибка при удалении Todo: \(error.localizedDescription)")
            throw error
        }
    }
    
}
