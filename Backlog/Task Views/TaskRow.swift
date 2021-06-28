//
//  TaskRow.swift
//  Backlog
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI
import CoreData


struct TaskRow: View {

    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showDetail = false
    @State var showGroup: Bool
    @ObservedObject var task: Task

    init(_ task: Task, showGroup: Bool = true) {
        self.task = task
        self.showGroup = showGroup
    }
    
    var body: some View {
        Button {
            showDetail.toggle()
        } label: {
            VStack(alignment: .leading) {
                Text(task.name ?? "no_name")
                    .font(.headline)
                if showGroup {
                    Text(task.group?.name ?? "no_groupname")
                        .font(.subheadline)
                }
                Text("\(task.deadline ?? Date(), formatter: dateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(task.deadline ?? .distantFuture < .now ? .red : .secondary)
            }
        }
        .foregroundColor(.primary)
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                viewContext.performAndWait {
                    task.completed.toggle()
                    try? viewContext.save()
                 }
            } label: {
                Label(task.completed ? "task_is_not_done" : "task_is_done",
                      image: task.completed ? "xmark.circle.fill" : "checkmark.circle.fill")
            }
            .tint(task.completed ? .red : .green)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                viewContext.performAndWait {
                    viewContext.delete(task)
                    try? viewContext.save()
                 }
            } label: {
                Label("delete_task", image: "minus.circle.fill")
            }
        }
        .sheet(isPresented: $showDetail) { TaskDetail(task: task) }
    }
}

struct AssignmentRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(Task())
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    return formatter
}()
