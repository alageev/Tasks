//
//  Persistence.swift
//  Tasks
//
//  Created by Алексей Агеев on 27.06.2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let firstTaskGroup = Group(context: viewContext)
        firstTaskGroup.name = "Group 1"
        
        let secondTaskGroup = Group(context: viewContext)
        secondTaskGroup.name = "Group 2"
        
        
        let outdatedTask = Task(context: viewContext)
        outdatedTask.name = "Outdated Task"
        outdatedTask.deadline = .distantPast
        outdatedTask.group = firstTaskGroup
        
        let thisWeekTask = Task(context: viewContext)
        thisWeekTask.name = "This Week Task"
        thisWeekTask.deadline = .now + 432_000
        thisWeekTask.group = secondTaskGroup
        
        let thisMonthTask = Task(context: viewContext)
        thisMonthTask.name = "This Month Task"
        thisMonthTask.deadline = .now + 1_209_600
        thisMonthTask.group = secondTaskGroup
        
        let otherTask = Task(context: viewContext)
        otherTask.name = "Other Task"
        otherTask.deadline = .distantFuture
        otherTask.group = secondTaskGroup
        
        let completedTask = Task(context: viewContext)
        completedTask.name = "Completed Task"
        completedTask.deadline = .distantFuture
        completedTask.group = secondTaskGroup
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Tasks")
        container.viewContext.automaticallyMergesChangesFromParent = true // idk if it will work
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
