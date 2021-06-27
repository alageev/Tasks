////
////  AssignmentRow.swift
////  Backlog
////
////  Created by Алексей Агеев on 27.06.2021.
////
//
//import SwiftUI
//import CoreData
//
//
//struct AssignmentRow: View {
//
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @State var selectedAssignment: Assignment?
//    let assignmentID: NSManagedObjectID
//
//    init(_ assignmentID: NSManagedObjectID) {
//        self.assignmentID = assignmentID
//    }
//
//    var body: some View {
//        Button {
//            selectedAssignment = assignment
//        } label: {
//            VStack(alignment: .leading) {
//                Text((viewContext.object(with: assignment.objectID) as? Assignment)?.name ?? "no name")
//                    .font(.body)
//                Text("\(assignment.dueTo!, formatter: itemFormatter)")
//                    .font(.footnote)
//            }
//        }
//        .foregroundColor(.primary)
//        .swipeActions(edge: .leading, allowsFullSwipe: true) {
//            Button {
//                viewContext.performAndWait {
//                    assignment.completed.toggle()
//                    try? viewContext.save()
//                 }
//            } label: {
//                Label("Done", image: "checkmark.circle.fill")
//            }
//            .tint(assignment.completed ? .red : .green)
//        }
//        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//            Button(role: .destructive) {
//                viewContext.delete(assignment)
//                try? viewContext.save()
//            } label: {
//                Label("Delete", image: "minus.circle.fill")
//            }
//        }
//    }
//}
//
//struct AssignmentRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AssignmentRow(Assignment())
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
