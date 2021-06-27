//
//  ContentView.swift
//  Backlog
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Assignment.dueTo, ascending: true)],
        animation: .default)
    
    private var assignments: FetchedResults<Assignment>

    @State var createSheetIsPresent = false
    @State var selectedAssignment: Assignment?
    
    var body: some View {
        NavigationView {
            List {
                Section("Not done") {
                    ForEach(assignments.filter { !$0.completed }) { assignment in
                        Button {
                            selectedAssignment = assignment
                        } label: {
                            VStack(alignment: .leading) {
                                Text(assignment.name ?? "no name")
                                    .font(.body)
                                Text("\(assignment.dueTo!, formatter: itemFormatter)")
                                    .font(.footnote)
                            }
                        }
                        .foregroundColor(.primary)
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                viewContext.performAndWait {
                                    assignment.completed.toggle()
                                    try? viewContext.save()
                                 }
                            } label: {
                                Label("Done", image: "checkmark.circle.fill")
                            }
                            .tint(assignment.completed ? .red : .green)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                viewContext.delete(assignment)
                                try? viewContext.save()
                            } label: {
                                Label("Delete", image: "minus.circle.fill")
                            }
                        }
                    }
                }
                Section("Done") {
                    ForEach(assignments.filter { $0.completed }) { assignment in
                        Button {
                            selectedAssignment = assignment
                        } label: {
                            VStack(alignment: .leading) {
                                Text(assignment.name ?? "no name")
                                    .font(.body)
                                Text("\(assignment.dueTo!, formatter: itemFormatter)")
                                    .font(.footnote)
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                viewContext.performAndWait {
                                    assignment.completed.toggle()
                                    try? viewContext.save()
                                 }
                            } label: {
                                Label("Not Done", image: "xmark.circle.fill")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                viewContext.delete(assignment)
                                try? viewContext.save()
                            } label: {
                                Label("Delete", image: "minus.circle.fill")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Assignments"))
            .sheet(isPresented: $createSheetIsPresent, content: {CreateAssignment()})
            .sheet(item: $selectedAssignment, content: {AssignmentDetail(assignment: $0)})
            .toolbar {
                Button {
                    createSheetIsPresent = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { assignments[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
