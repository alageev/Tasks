//
//  CreateAssignment.swift
//  Backlog
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI

struct CreateAssignment: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var assignmentName = ""
    @State var assignmentDeadline = Date()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("assignment_name", text: $assignmentName)
                DatePicker("due_to", selection: $assignmentDeadline)
            }
            .navigationTitle(Text("create_new_assignment"))
            .navigationBarItems(leading: cancelButton, trailing: addButton)
        }
    }
    
    var addButton: some View {
        Button {
            addAssignment()
        } label: {
             Text("Add")
        }
    }
    
    var cancelButton: some View {
        Button(role: .cancel) {
            presentationMode.wrappedValue.dismiss()
        } label: {
             Text("Cancel")
        }
    }
    
    private func addAssignment() {
        let newItem = Assignment(context: viewContext)
        newItem.dueTo = assignmentDeadline
        newItem.name = assignmentName
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateAssignment_Previews: PreviewProvider {
    static var previews: some View {
        CreateAssignment()
    }
}
