//
//  Tasks__iOS_App.swift
//  Tasks (iOS)
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI

@main
struct Tasks__iOS_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
