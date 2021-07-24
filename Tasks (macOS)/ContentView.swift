//
//  ContentView.swift
//  Tasks (macOS)
//
//  Created by Алексей Агеев on 11.07.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("sortingOption") var sortingOption = SortingOption.byDeadline

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: true)], animation: .default)
    private var tasks: FetchedResults<Task>
    
    @State var createSheetIsPresent = false
    @State private var selectedTask: Task.ID?
    
    var body: some View {
        NavigationView {
            Sidebar(selection: $selectedTask, tasks: tasks)
            TaskDetail(task: tasks.filter({ $0.id == selectedTask}).first)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
