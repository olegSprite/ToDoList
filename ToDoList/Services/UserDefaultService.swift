//
//  UserDefaultService.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 04.12.2024.
//

import Foundation

enum userDefaultsKeys: String {
    case isFirstLaunch = "isFirstLaunch"
}

final class UserDefaultService {
    
    static func checkFirstLaunch() -> Bool {
        if UserDefaults.standard.bool(forKey: userDefaultsKeys.isFirstLaunch.rawValue) {
            return false
        }
        return true
    }
    
    static func aplicationLaunchedFirstTime() {
        UserDefaults.standard.set(true, forKey: userDefaultsKeys.isFirstLaunch.rawValue)
    }
}
