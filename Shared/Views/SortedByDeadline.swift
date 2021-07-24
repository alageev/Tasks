//
//  SortedByDeadline.swift
//  Tasks
//
//  Created by Алексей Агеев on 11.07.2021.
//

import SwiftUI

struct SortedByDeadline: View {
    
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
        #if os(iOS)
            TasksSection(header: "outdated_tasks",  tasks: outdatedTasks)
            TasksSection(header: "this_week",       tasks: tasksThisWeek)
            TasksSection(header: "this_month",      tasks: tasksThisMonth)
            TasksSection(header: "other_tasks",     tasks: otherTasks)
            TasksSection(header: "completed_tasks", tasks: completedTasks)
        #elseif os(macOS)
            TasksGroup(header: "outdated_tasks", tasks: outdatedTasks)
                .accentColor(.red)
            TasksGroup(header: "this_week", tasks: tasksThisWeek)
            TasksGroup(header: "this_month", tasks: tasksThisMonth)
            TasksGroup(header: "other_tasks", tasks: otherTasks)
            TasksGroup(header: "completed_tasks", tasks: completedTasks)
                .accentColor(.green)
        #endif
    }
}

//struct SortedByDeadline_Previews: PreviewProvider {
//    static var previews: some View {
//        SortedByDeadline(FetchedResults<Task>.)
//    }
//}
