//
//  SortedByGroupView.swift
//  Tasks
//
//  Created by Алексей Агеев on 28.06.2021.
//

import SwiftUI

struct SortedByGroupView: View {
    
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
            Section(LocalizedStringKey(group.isEmpty ? "tasks_without_group" : group)) {
                ForEach(tasks[group]!, id: \.self) { task in
                    TaskRow(task, showGroup: false)
                }
            }
        }
        if !completedTasks.isEmpty {
            Section(header: Text("completed_tasks")) {
                ForEach(completedTasks) { task in
                    TaskRow(task)
                }
            }
        }
    }
}

//struct SortedByGroupsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortedByGroupView()
//    }
//}
