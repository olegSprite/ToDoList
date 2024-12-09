//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Олег Спиридонов on 08.12.2024.
//

import XCTest
@testable import ToDoList

final class MainScreenPresenterTests: XCTestCase {
    
    var presenter: MainScreenPresenter!
    var mockView: MockMainScreenView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        presenter = MainScreenPresenter(router: mockRouter, interactor: mockInteractor)
        mockView = MockMainScreenView()
        presenter.view = mockView
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        super.tearDown()
    }
    
    func testTodosIsLoadedCallsReloadData() {
        // Arrange
        let sampleTodos = [Todo(id: UUID(), title: "Test Title", todo: "Test Description", completed: true, date: Date())]
        
        // Act
        presenter.todosIsLoaded(todos: sampleTodos)
        
        // Assert
        XCTAssertEqual(presenter.tasks, sampleTodos, "tasks должны обновиться корректно")
        XCTAssertEqual(presenter.fillteredTasks, sampleTodos, "fillteredTasks должны обновиться корректно")
        XCTAssertTrue(mockView.isReloadDataCalled, "Метод reloadData должен быть вызван")
    }
    
    func testViewDidLoadedCallsFetchData() {
        // Act
        presenter.viewDidLoaded()
        
        // Assert
        XCTAssertTrue(mockInteractor.isFetchDataCalled, "Метод fetchData должен быть вызван")
    }
    
    func testFilterTodosBySearchText() {
        // Arrange
        let todos = [
            Todo(id: UUID(), title: "Title", todo: "Test1", completed: true, date: Date()),
            Todo(id: UUID(), title: "Title", todo: "Test2", completed: true, date: Date()),
            Todo(id: UUID(), title: "Title", todo: "Test3", completed: true, date: Date())
        ]
        presenter.tasks = todos
        
        // Act
        presenter.filterTodos(by: "Test1")
        
        // Assert
        XCTAssertEqual(presenter.fillteredTasks, [todos[0]], "Должен остаться только элемент, содержащий 'milk'")
        XCTAssertTrue(mockView.isReloadDataCalled, "Метод reloadData должен быть вызван")
    }
    func testClearSearchResetsFilteredTasks() {
        // Arrange
        let todos = [
            Todo(id: UUID(), title: "Title", todo: "Test1", completed: true, date: Date()),
            Todo(id: UUID(), title: "Title", todo: "Test2", completed: true, date: Date()),
            Todo(id: UUID(), title: "Title", todo: "Test3", completed: true, date: Date())
        ]
        presenter.tasks = todos
        presenter.fillteredTasks = [todos[0]]

        // Act
        presenter.clearCearch()

        // Assert
        XCTAssertEqual(presenter.fillteredTasks, todos, "fillteredTasks должен совпадать с tasks после сброса")
        XCTAssertTrue(mockView.isReloadDataCalled, "Метод reloadData должен быть вызван")
    }
    
    func testNewTaskButtonTappedCallsRouter() {
        // Act
        presenter.newTaskButtonTapped()

        // Assert
        XCTAssertTrue(mockRouter.isOpenCreatingTodoScreenCalled, "Метод openCreatingTodoScreen должен быть вызван")
    }
}
