//
//  TaskDetail.swift
//  Tasks
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI

struct TaskDetail: View {
    
    let task: Task
    
    var body: some View {
        List {
            Section(header: Text("task_name")) {
                Text(task.name ?? "no_name")
            }
            
            Section(header: Text("group_name")) {
                Text(task.group?.name ?? "no_groupname")
            }
            
            if task.deadline != nil {
                Section(header: Text("task_deadline")) {
                    Text(task.deadline!, formatter: dateFormatter)
                }
            }
            
            Section(header: Text("task_notes")) {
                Text(LocalizedStringKey(task.comment ?? "no_notes"))
                    .foregroundColor(task.comment == nil ? .secondary : .primary)
            }
        }
        .navigationBarTitle(Text(task.name ?? "task"))
    }
}

struct TaskDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: Task())
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    return formatter
}()
