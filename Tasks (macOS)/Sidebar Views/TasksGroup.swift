//
//  TasksGroup.swift
//  Tasks (macOS)
//
//  Created by Алексей Агеев on 11.07.2021.
//

import SwiftUI

struct TasksGroup: TaskGroupViewProtocol {
    
    let header: LocalizedStringKey
    let tasks: [Task]
    
    @State var expansionState = true
    
    init(header: LocalizedStringKey, tasks: [Task]) {
        self.header = header
        self.tasks = tasks
    }
        
    var body: some View {
        if !tasks.isEmpty {
            DisclosureGroup(header, isExpanded: $expansionState) {
                ForEach(tasks) { task in
                    Label(task.name!, systemImage: "list.bullet.circle")
                        .accentColor(task.deadline! > .now || task.completed ? .accentColor : .red)
                }
            }
        }
    }
}

struct TasksGroup_Previews: PreviewProvider {
    static var previews: some View {
        TasksGroup(header: "", tasks: [])
    }
}
