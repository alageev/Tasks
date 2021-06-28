//
//  TasksApp.swift
//  Tasks
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI

@main
struct TasksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
