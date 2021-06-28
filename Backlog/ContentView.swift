//
//  ContentView.swift
//  Backlog
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    enum SortingOption {
        case byDeadline
        case byGroup
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<Task>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Group.name, ascending: true)],
        animation: .default)
    private var groups: FetchedResults<Group>

    @State var createSheetIsPresent = false
    @State var sortingOption = SortingOption.byDeadline
    @State var showSelectSortingOptionAlert = false
    @State var selectedTask: Task?
    
    var body: some View {
        NavigationView {
            List {
                switch sortingOption {
                case .byDeadline:
                    SortedByDeadlineView(tasks)
                case .byGroup:
                    SortedByGroupView(tasks)
                }
            }
            .navigationBarTitle(Text("tasks"))
            .sheet(isPresented: $createSheetIsPresent) { CreateTask(groups: groups) }
            .confirmationDialog("sort_by_dialog", isPresented: $showSelectSortingOptionAlert, titleVisibility: .visible) {
                Button {
                    withAnimation {
                        sortingOption = .byDeadline
                    }
                } label: {
                    Label("by_deadline", systemImage: "clock.badge.checkmark")
                }
                Button {
                    withAnimation {
                        sortingOption = .byGroup
                    }
                } label: {
                    Label("by_group", systemImage: "folder")
                }
                Button("cancel", role: .cancel) { }
            }
            .navigationBarItems(
                leading:
                    Button {
                        showSelectSortingOptionAlert = true
                    } label: {
                        Label("sort", systemImage: "arrow.up.arrow.down")
                    },
                trailing:
                    Button {
                        createSheetIsPresent = true
                    } label: {
                        Label("add_Item", systemImage: "plus")
                    })
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
