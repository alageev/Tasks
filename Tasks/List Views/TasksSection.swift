//
//  TasksSection.swift
//  Tasks
//
//  Created by Алексей Агеев on 21.07.2021.
//

import SwiftUI

struct TasksSection: View {
    let header: LocalizedStringKey
    let tasks: [Task]
    
    var body: some View {
        if !tasks.isEmpty {
            Section(header) {
                ForEach(tasks) { task in
                    TaskRow(task)
                }
            }
        }
    }
}

struct TasksSection_Previews: PreviewProvider {
    static var previews: some View {
        TasksSection(header: "test_header", tasks: [Task()])
    }
}
