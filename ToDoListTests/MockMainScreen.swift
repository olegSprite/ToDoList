//
//  MockMainScreenView.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 09.12.2024.
//

@testable import ToDoList

class MockMainScreenView: MainScreenViewProtocol {
    
    var isReloadDataCalled = false

    func reloadData() {
        isReloadDataCalled = true
    }
    
    func fetchNewData() {}
}

class MockRouter: MainScreenRouterProtocol {
    var isOpenCreatingTodoScreenCalled = false

    func openCreatingTodoScreen() {
        isOpenCreatingTodoScreenCalled = true
    }

    func openEditScreen(todo: Todo) {}
}

class MockInteractor: MainScreenInteractorProtocol {
    var isFetchDataCalled = false

    func fetchData() {
        isFetchDataCalled = true
    }

    func todoCompletedToggle(todo: Todo) {}
    func delete(todo: Todo) {}
}
