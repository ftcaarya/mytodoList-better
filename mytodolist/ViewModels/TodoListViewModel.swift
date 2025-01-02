//
//  TodoListViewModel.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import Foundation

class TodoListViewModel : ObservableObject   {
    @Published var todoList = [TodoItem]()
    @Published var loading = false;
    @Published var isShowingTaskDetailView  = false
    @Published var errorMessage = ""
    @Published var refreshTodo  = false
    @Published var taskName: String = ""
        
    var selectedTask : TodoItem? {
        didSet {
            isShowingTaskDetailView = true
            taskName = selectedTask?.taskName ?? ""
        }
    }
    
    func deleteTask(todoTaskObj : TodoItem ) {
        self.loading = true;
        WebService().dleteTodoItem( todoTaskId : todoTaskObj.id ?? "000") { result in
                switch result {
                case .failure(let error):
                    self.loading = false;
                    print("<error>", error)
                    self.errorMessage = ""
                    self.errorMessage = "Task Deletion Failed"
                case .success(let task):
                    self.loading = false;
                    print("<Deleted task>", task)
                    self.refreshTodo = true;
                }
        }
    }
    
    func fetchTodoDataV1(userId : String) async {
        guard let downloadedPosts: [TodoItem] = await WebService().fetchTodoV1(fromURL: Constants.Urls.todoListByUser(userId: userId)) else {return}
        todoList = downloadedPosts
        print(todoList.count)
    }
    
    func loadTodoList(userId : String) async {
        print("Inside loadTodoList ..")
            do {
                self.loading = true
//                DispatchQueue.main.async {
                    todoList = try await WebService().fetchTodo(fromURL: Constants.Urls.todoListByUser(userId: userId))
                    print("<todoList.count>", todoList.count)
//                }
                self.loading = false
            } catch {
                self.loading = false
                print(error.localizedDescription)
            }
    }
    
    func addTodoItem(todoTaskObj :TodoItem) {
        print("Inside addTodo ..")
//        guard validate() else {
//            return
//        }
        
        //Call API
        self.loading = true;
        WebService().addTodoItem(todoTaskObj : todoTaskObj ) { result in
                switch result {
                case .failure(let error):
                    self.loading = false;
                    print("<error>", error)
                    self.errorMessage = ""
                    self.errorMessage = "Task Creation Failed"
                case .success(let task):
                    self.loading = false;
                    print("<Created task>", task)
                    print("After self.refreshTodo :" , self.refreshTodo)
                    if(task.id == nil) {
                        self.errorMessage = ""
                        self.errorMessage = "Task Creation Failed"
                    }else {
                        self.errorMessage = ""
                        self.refreshTodo = true;
                        print("After self.refreshTodo :" , self.refreshTodo)
                    }
                }
        }
    }
    
    func updateTodoItem(todoTaskObj :TodoItem) {
        print("Inside updateTodoItem ..")
//        guard validate() else {
//            return
//        }
        
        //Call API
        self.loading = true;
        WebService().updateTodoItem(todoTaskObj : todoTaskObj ) { result in
                switch result {
                case .failure(let error):
                    self.loading = false;
                    print("<error>", error)
                    self.errorMessage = ""
                    self.errorMessage = "Task Update Failed"
                case .success(let task):
                    self.loading = false;
                    print("<Updated task>", task)
                    print("After self.refreshTodo :" , self.refreshTodo)
                    if(task.id == nil) {
                        self.errorMessage = ""
                        self.errorMessage = "Task Update Failed"
                    }else {
                        self.errorMessage = ""
                        self.refreshTodo = true;
                        print("After self.refreshTodo :" , self.refreshTodo)
                    }
                }
        }
    }
   

    
}
