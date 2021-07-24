//
//  Sidebar.swift
//  Tasks (macOS)
//
//  Created by Алексей Агеев on 11.07.2021.
//

import SwiftUI

struct Sidebar: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("sortingOption") var sortingOption = SortingOption.byDeadline
    @Binding var selection: Task.ID?
    @State var showSelectSortingOptionAlert = false
    let tasks: FetchedResults<Task>
    
    var body: some View {
        List(selection: $selection) {
            switch sortingOption {
            case .byDeadline:
                SortedByDeadline(tasks)
            case .byGroup:
                SortedByGroup(tasks)
            }
        }
        .onDeleteCommand {
            guard let task = tasks.filter({ $0.id == selection }).first else { return }
            viewContext.performAndWait {
                viewContext.delete(task)
                try? viewContext.save()
            }
        }
        .animation(.easeInOut, value: sortingOption)
        .navigationTitle(Text("tasks"))
        .deleteDisabled(false)
//        .sheet(isPresented: $createSheetIsPresent) { CreateTask(groups: groups) }
        .confirmationDialog("sort_by_dialog", isPresented: $showSelectSortingOptionAlert) {
            Button {
                sortingOption = .byDeadline
            } label: {
                Label("by_deadline", systemImage: "clock.badge.checkmark")
            }
            Button {
                sortingOption = .byGroup
            } label: {
                Label("by_group", systemImage: "folder")
            }
            Button("cancel", role: .cancel) { }
        }
        .toolbar {
            Menu {
                Button {
                    sortingOption = .byDeadline
                } label: {
                    Label("by_deadline", systemImage: "clock.badge.checkmark")
                }
                Button {
                    sortingOption = .byGroup
                } label: {
                    Label("by_group", systemImage: "folder")
                }
            } label: {
                Label("sort", systemImage: "arrow.up.arrow.down")
            }
            Button {
//                    createSheetIsPresent = true
                addTask()
            } label: {
                Label("add_task", systemImage: "plus")
            }
        }
    }
    private func addTask() {
        
        let newItem = Task(context: viewContext)
        newItem.deadline = .now
        newItem.name = "test"
        let group = Group(context: viewContext)
        group.name = "group"
        newItem.group = group
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

//struct Sidebar_Previews: PreviewProvider {
//    static var previews: some View {
//        Sidebar(tasks: [Task](), selection: .constant(Task().id))
//    }
//}

