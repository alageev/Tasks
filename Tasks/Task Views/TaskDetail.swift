//
//  TaskDetail.swift
//  Tasks (iOS)
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI
import CoreData

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
                    Text(task.deadline!, formatter: CustomDateFormatter())
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
    
    private static let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
    private static let tasks =
    try? PersistenceController.preview.container.viewContext.fetch(fetchRequest).sorted(by: { $0.deadline! < $1.deadline! })
    
    static var previews: some View {
        TaskDetail(task: tasks?[0] ?? Task())
            .previewLayout(.sizeThatFits)
    }
}
