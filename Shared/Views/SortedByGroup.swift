//
//  SortedByGroup.swift
//  Tasks
//
//  Created by Алексей Агеев on 11.07.2021.
//

import SwiftUI

struct SortedByGroup: View {
    
    let fetchedTasks: FetchedResults<Task>
    var tasks = [String: [Task]]()
    var completedTasks = [Task]()
    
    init(_ tasks: FetchedResults<Task>) {
        self.fetchedTasks = tasks
        var temp = [String: Set<Task>]()
        for task in tasks {
            if task.completed {
                completedTasks.append(task)
                continue
            }
            
            let groupName = task.group?.name ?? ""
            if temp.keys.contains(groupName) {
                temp[groupName]!.insert(task)
            } else {
                temp.updateValue([task], forKey: groupName)
            }
        }
        
        for (key, value) in temp {
            self.tasks.updateValue(
                value
                    .sorted { $0.name! < $1.name! }
                    .sorted { $0.deadline! < $1.deadline! },
                forKey: key)
        }
    }
    
    var body: some View {
        
        ForEach(tasks.keys.sorted { $0 < $1 }, id: \.self) { group in
            #if os(iOS)
                TasksSection(header: group.isEmpty ? "tasks_without_group" : LocalizedStringKey(group),
                             tasks: tasks[group]!)
            #elseif os(macOS)
                TasksGroup(header: group.isEmpty ? "tasks_without_group" : LocalizedStringKey(group),
                           tasks: tasks[group]!)
            #endif
        }
        #if os(iOS)
            TasksSection(header: "completed_tasks", tasks: completedTasks, showGroup: true)
        #elseif os(macOS)
            TasksGroup(header: "completed_tasks", tasks: completedTasks)
        #endif
    }
}

//struct SortedByGroups_Previews: PreviewProvider {
//    static var previews: some View {
//        SortedByGroup()
//    }
//}
