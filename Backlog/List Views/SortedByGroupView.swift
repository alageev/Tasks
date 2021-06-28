//
//  SortedByGroupView.swift
//  Backlog
//
//  Created by Алексей Агеев on 28.06.2021.
//

import SwiftUI

struct SortedByGroupView: View {
    
    var tasks = [String: [Task]]()
    
    init(_ tasks: FetchedResults<Task>) {
        var temp = [String: Set<Task>]()
        for task in tasks {
            let groupName = task.group?.name ?? ""
            if temp.keys.contains(groupName) {
                temp[groupName]!.insert(task)
            } else {
                temp.updateValue([task], forKey: groupName)
            }
        }
        
        for (key, value) in temp {
            self.tasks.updateValue(
                value
                    .sorted { $0.name! < $1.name! }
                    .sorted { $0.deadline! < $1.deadline! },
                forKey: key)
        }
    }
    
    var body: some View {
        ForEach(tasks.keys.sorted { $0 < $1 }, id: \.self) { group in
            Section(group.isEmpty ? "tasks_without_group" : group) {
                ForEach(tasks[group]!, id: \.self) { task in
                    TaskRow(task, showGroup: false)
                }
            }
        }
    }
}

//struct SortedByGroupsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortedByGroupView()
//    }
//}
