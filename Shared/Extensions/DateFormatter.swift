//
//  DateFormatter.swift
//  Tasks
//
//  Created by Алексей Агеев on 22.07.2021.
//

import Foundation

extension DateFormatter {
    static let fullDateNoneTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()
}
