//
//  CustomDateFormatter.swift
//  Tasks
//
//  Created by Алексей Агеев on 22.07.2021.
//

import Foundation

class CustomDateFormatter: DateFormatter {
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()
    
    func callAsFunction() -> DateFormatter {
        return dateFormatter
    }
}
