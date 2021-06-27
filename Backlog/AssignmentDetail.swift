//
//  AssignmentDetail.swift
//  Backlog
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI

struct AssignmentDetail: View {
    
    let assignment: Assignment
    
    var body: some View {
        NavigationView {
            List {
                Text(assignment.name!)
                Text(assignment.dueTo!, formatter: itemFormatter)
                Text(assignment.completed ? "Yes" : "No")
            }
            .navigationTitle(Text("create_new_assignment"))
        }
    }
}

struct AssignmentDetail_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentDetail(assignment: Assignment())
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
