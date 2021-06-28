//
//  CreateTask.swift
//  Tasks
//
//  Created by Алексей Агеев on 27.06.2021.
//

import SwiftUI

struct CreateTask: View {
    
    enum Field {
        case taskName
        case taskGroup
        case taskDeadline
        case taskNotes
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var taskName = ""
    @State var groupName = ""
    @State var taskDeadline = Date()
    @State var taskComment = ""
    @FocusState var focusedField: Field?
    
    let groups: FetchedResults<Group>
    
    var body: some View {
        NavigationView {
            Form {
                Section(LocalizedStringKey("task_name")) {
                    TextField("task_name", text: $taskName)
                        .focused($focusedField, equals: .taskName)
                        .submitLabel(.next)
                }
                Section(LocalizedStringKey("group_name")) {
                    TextField("group_name", text: $groupName)
                        .focused($focusedField, equals: .taskGroup)
                        .submitLabel(.next)
                }
                
                Section {
                    DatePicker("task_deadline", selection: $taskDeadline, displayedComponents: .date)
                        .focused($focusedField, equals: .taskDeadline)
                        .submitLabel(.next)
                }
                
                Section(LocalizedStringKey("task_notes")) {
                    TextEditor(text: $taskComment)
                        .focused($focusedField, equals: .taskNotes)
                }
            }
            .onSubmit {
                switch focusedField {
                case .taskName:
                    focusedField = .taskGroup
                case .taskGroup:
                    focusedField = .taskDeadline
                case .taskDeadline:
                    focusedField = .taskNotes
                case .taskNotes:
                    break
                default:
                    break
                }
            }
            .navigationBarTitle(Text(LocalizedStringKey($taskName.wrappedValue.isEmpty ? "create_new_task" : $taskName.wrappedValue)))
            .navigationBarItems(leading: cancelButton, trailing: addButton)
        }
    }
    
    var addButton: some View {
        Button {
            addTask()
        } label: {
             Text("add_Item")
        }
    }
    
    var cancelButton: some View {
        Button(role: .cancel) {
            presentationMode.wrappedValue.dismiss()
        } label: {
             Text("cancel")
        }
    }
    
    private func addTask() {
        
        var group = groups.filter { $0.name == groupName.trimmingCharacters(in: [" "]) }.first
        
        let newItem = Task(context: viewContext)
        newItem.deadline = taskDeadline
        newItem.name = taskName.trimmingCharacters(in: [" "])
        if group == nil {
            group = Group(context: viewContext)
            group!.name = groupName.trimmingCharacters(in: [" "])
        }
        newItem.group = group
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

//struct CreateTask_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateTask()
//    }
//}
