//
//  TasksSection.swift
//  Tasks (iOS)
//
//  Created by Алексей Агеев on 21.07.2021.
//

import SwiftUI

struct TasksSection: TaskGroupViewProtocol {
    let header: LocalizedStringKey
    let tasks: [Task]
    var showGroup: Bool
    
    
    init(header: LocalizedStringKey, tasks: [Task]) {
        self.header = header
        self.tasks = tasks
        showGroup = false
    }
    
    init(header: LocalizedStringKey, tasks: [Task], showGroup: Bool) {
        self.init(header: header, tasks: tasks)
        self.showGroup = showGroup
    }
    
    var body: some View {
        if !tasks.isEmpty {
            Section(header) {
                ForEach(tasks) { task in
                    TaskRow(task, showGroup: showGroup)
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
