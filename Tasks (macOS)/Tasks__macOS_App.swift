//
//  Tasks__macOS_App.swift
//  Tasks (macOS)
//
//  Created by Алексей Агеев on 22.07.2021.
//

import SwiftUI

@main
struct Tasks__macOS_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
