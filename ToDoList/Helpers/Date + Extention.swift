//
//  Date + Extention.swift
//  ToDoList
//
//  Created by Олег Спиридонов on 03.12.2024.
//

import Foundation

extension Date {
    
    func formattedToAppFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }
}
