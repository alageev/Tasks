//
//  SortingOption.swift
//  Tasks
//
//  Created by Алексей Агеев on 22.07.2021.
//

enum SortingOption: String, Identifiable, CaseIterable {
    case byDeadline
    case byGroup
    
    var id: String { rawValue }
}
