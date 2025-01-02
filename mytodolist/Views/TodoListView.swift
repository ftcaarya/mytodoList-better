//
//  TodoListView.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import SwiftUI

struct TodoListView: View {
    @Environment(AppState.self) private var appState : AppState
    @StateObject var vm = TodoListViewModel()
    @State var isUpdateTask : Bool = false
    
    var body: some View {
        ActivityIndicatorView(isShowing : $vm.loading) {
            NavigationView {
                List() {
                    ForEach(vm.todoList) { todoItem in
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(todoItem.taskName)
                                        .bold()
                                        .lineLimit(1)
                                        .onTapGesture {
                                            vm.selectedTask = todoItem
                                            isUpdateTask = true;
                                        }
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: getImageName(status : todoItem.status))
                                            .foregroundColor(getColor(status : todoItem.status))
                                    }
                                }
                                VStack {
                                    Text(todoItem.taskNotes)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    .lineLimit(2)
                                }
                            }
                        }
                    }.onDelete { indexSet in
                        for i in indexSet.makeIterator() {
                            vm.deleteTask(todoTaskObj: vm.todoList[i])
                        }
                }
                   }
//                    .task(id : vm.refreshTodo) {
//                        print("vm.refreshTodo task triggered..")
//                            await vm.loadTodoList(userId: self.appState.user.userId ?? "sar762009@gmail.com")
//                    }
                    .navigationTitle("To Do List")
                    .onAppear {
                        print("onAppearonAppear  called..")
                        if (vm.todoList.isEmpty || vm.refreshTodo) {
                           Task {
                               await vm.fetchTodoDataV1(userId: self.appState.user.userId ?? "sar762009@gmail.com")
                           }
                       }
                   }
                   .toolbar {
                       Button {
                           isUpdateTask = false;
                           vm.selectedTask = nil
                           vm.isShowingTaskDetailView = true
                       } label: {
                           Image(systemName: "plus")
                       }
                       Button {
                           Task {
                               await vm.loadTodoList(userId: self.appState.user.userId ?? "sar762009@gmail.com")
                           }
                       } label: {
                           Image(systemName: "arrow.clockwise")
                       }
                   }
                   .sheet(isPresented: $vm.isShowingTaskDetailView){
                       AddTodoView(isShowingTaskDetailView : $vm.isShowingTaskDetailView,isUpdateTask: $isUpdateTask, selectedDocId :vm.selectedTask?.id ?? "000", selectedTaskName : vm.selectedTask?.taskName ?? "", selectedTaskNotes : vm.selectedTask?.taskNotes ?? "", selectedTaskStatus : vm.selectedTask?.status ?? "Open")
                   }
            }
        }
        
     }
    
    func getImageName(status : String) -> String{
        if(status == "Open") {
            return "x.square"
        }else if (status == "Closed") {
            return "checkmark.circle"
        }else if (status == "In Progress") {
            return "minus.rectangle"
        }else {
            return "plus"
        }
    }
    
    func getColor(status : String) -> Color{
        if(status == "Open") {
            return Color(.green)
        }else if (status == "Closed") {
            return Color(.green)
        }else if (status == "In Progress") {
            return Color(.orange)
        }else {
            return Color(.blue)
        }
    }
}

#Preview {
    TodoListView()
        .environment(AppState())
}
