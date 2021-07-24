//
//  TaskRow.swift
//  Tasks (iOS)
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
        NavigationLink(destination: TaskDetail(task: task)) {
            VStack(alignment: .leading) {
                Text(task.name ?? "no_name")
                    .font(.headline)
                    .foregroundColor(.primary)
                if showGroup, task.group?.name != nil {
                    Text(task.group!.name!)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if task.deadline != nil {
                    Text("\(task.deadline!, formatter: dateFormatter)")
                        .font(.subheadline)
                        .foregroundColor(task.deadline! > .now || task.completed ? .secondary : .red)
                }
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                viewContext.performAndWait {
                    task.completed.toggle()
                    try? viewContext.save()
                 }
            } label: {
                Label(task.completed ? "task_is_not_done" : "task_is_done",
                      systemImage: task.completed ? "xmark.circle.fill" : "checkmark.circle.fill")
                    .labelStyle(.titleAndIcon)
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
                Label("delete_task", systemImage: "minus.circle.fill")
                    .labelStyle(.titleAndIcon)
            }
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    private static let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
    private static let tasks =
    try? PersistenceController.preview.container.viewContext.fetch(fetchRequest).sorted(by: { $0.deadline! < $1.deadline! })
    
    static var previews: some View {
        TaskRow(tasks?[0] ?? Task())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding()
            .background(Color(uiColor: .systemGroupedBackground))
        TaskRow(tasks?[1] ?? Task())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding()
            .background(Color(uiColor: .systemGroupedBackground))
        TaskRow(tasks?[2] ?? Task())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding()
            .background(Color(uiColor: .systemGroupedBackground))
        TaskRow(tasks?[3] ?? Task())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding()
            .background(Color(uiColor: .systemGroupedBackground))
        TaskRow(tasks?[4] ?? Task())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding()
            .background(Color(uiColor: .systemGroupedBackground))
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    return formatter
}()
