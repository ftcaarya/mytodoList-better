//
//  AddTodoView.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(AppState.self) private var appState : AppState
    
    @StateObject var viewModel = TodoListViewModel()
    
    @Binding var isShowingTaskDetailView : Bool
    @Binding var isUpdateTask : Bool
    var selectedDocId: String = ""
    @State var selectedTaskName: String = ""
    @State var selectedTaskNotes: String = ""
    @State var selectedTaskStatus: String = ""
    @State var selectedTaskTargetDate = Date.now
    let formatter1: () = DateFormatter().dateStyle = .short
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateStyle = .short
            return formatter
    }()
    
    var body: some View {
        
        VStack {
            Text((isUpdateTask) ? "Update Task" : "New Task")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            
            Form {
                
                TextField("Task Name", text: $selectedTaskName)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                TextField("Notes", text: $selectedTaskNotes)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                Picker("Status", selection: $selectedTaskStatus) {
                    Text("Open").tag("Open")
                    Text("In Progress").tag("In Progress")
                    Text("Cancel").tag("Cancel")
                    Text("Closed").tag("Closed")
                }
                DatePicker("Target Date", selection: $selectedTaskTargetDate , displayedComponents: [.date])
                
                Spacer()
                if(isUpdateTask) {
                    Button{
                        updateTask()
                        isShowingTaskDetailView = false
                    }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.blue)
                                Text("Update")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                    }
                }else {
                    Button{
                        addTask()
                        isShowingTaskDetailView = false
                    }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.blue)
                                Text("Create")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                    }
                }
                
 
                Button{
                    isShowingTaskDetailView = false
                }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.red)
                            Text("Cancel")
                                .foregroundColor(.white)
                                .bold()
                        }
                }
            }
       }
        Spacer()
    }
    
    func updateTask() {
        print("selectedDocId :", selectedDocId)
        let updateTask = TodoItem(id: selectedDocId, taskName: selectedTaskName, taskNotes: selectedTaskNotes, userId: self.appState.user.userId ?? "sar762009@gmail.com", status: selectedTaskStatus, targetDate: dateFormatter.string(from: selectedTaskTargetDate))
        viewModel.updateTodoItem(todoTaskObj: updateTask);
        isShowingTaskDetailView = false
    }
    
    func addTask() {
        let newTask = TodoItem(id: "000", taskName: selectedTaskName, taskNotes: selectedTaskNotes, userId: self.appState.user.userId ?? "sar762009@gmail.com", status: selectedTaskStatus, targetDate: dateFormatter.string(from: selectedTaskTargetDate))
        viewModel.addTodoItem(todoTaskObj: newTask);
        isShowingTaskDetailView = false
    }
}

#Preview {
    AddTodoView(isShowingTaskDetailView: .constant(true), isUpdateTask: .constant(false), selectedDocId : "0000", selectedTaskName : "New Task", selectedTaskNotes : "New Notes", selectedTaskStatus : "Open").environment(AppState())
}
