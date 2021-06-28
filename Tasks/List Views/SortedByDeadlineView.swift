//
//  SortedByDeadlineView.swift
//  Tasks
//
//  Created by Алексей Агеев on 28.06.2021.
//

import SwiftUI

struct SortedByDeadlineView: View {
    
    let tasks: FetchedResults<Task>
    let outdatedTasks: [Task]
    let tasksThisWeek: [Task]
    let tasksThisMonth: [Task]
    let otherTasks: [Task]
    let completedTasks: [Task]
    
    init(_ tasks: FetchedResults<Task>) {
        self.tasks = tasks
        let uncompletedTasks = tasks.filter { !$0.completed }
        
        let outdatedTasks = uncompletedTasks.filter { $0.deadline ?? .distantFuture < .now }
        
        let tasksThisWeek = uncompletedTasks
            .filter { $0.deadline ?? .distantFuture < .now.addingTimeInterval(604_800) } // 7 * 24 * 60 * 60 secs
            .filter { $0.deadline ?? .distantFuture > .now }
        
        let tasksThisMonth = uncompletedTasks
            .filter { !tasksThisWeek.contains($0) }
            .filter { $0.deadline ?? .distantFuture < .now.addingTimeInterval(2_419_200) } // 4 * 7 * 24 * 60 * 60 secs
            .filter { $0.deadline ?? .distantFuture > .now }
        
        self.outdatedTasks = outdatedTasks
        self.tasksThisWeek = tasksThisWeek
        self.tasksThisMonth = tasksThisMonth
        self.otherTasks = uncompletedTasks
            .filter { !tasksThisWeek.contains($0) }
            .filter { !tasksThisMonth.contains($0) }
            .filter { !outdatedTasks.contains($0) }
        self.completedTasks = tasks.filter { $0.completed }
    }
    
    var body: some View {
        if !outdatedTasks.isEmpty {
            Section(header: Text("outdated_tasks")) {
                ForEach(outdatedTasks) { task in
                    TaskRow(task)
                }
            }
        }
        if !tasksThisWeek.isEmpty {
            Section(header: Text("this_week")) {
                ForEach(tasksThisWeek) { task in
                    TaskRow(task)
                }
            }
        }
        if !tasksThisMonth.isEmpty {
            Section(header: Text("this_month")) {
                ForEach(tasksThisMonth) { task in
                    TaskRow(task)
                }
            }
        }
        if !otherTasks.isEmpty {
            Section(header: Text("other_tasks")) {
                ForEach(otherTasks) { task in
                    TaskRow(task)
                }
            }
        }
        if !completedTasks.isEmpty {
            Section(header: Text("completed_tasks")) {
                ForEach(completedTasks) { task in
                    TaskRow(task)
                }
            }
        }
    }
}

//struct SortedByDeadlineView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortedByDeadlineView(FetchedResults<Task>.)
//    }
//}
