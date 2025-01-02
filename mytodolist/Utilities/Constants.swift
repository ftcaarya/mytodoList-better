//
//  Constants.swift
//  NearMe
//
//  Created by  Saravanan Saminathan on 6/20/24.
//



import Foundation

struct Constants {
    struct Urls {
        static func todoListByUser(userId: String) -> URL {
            return URL(string: "https://mytodolist-gateway-dhtwe5fo.uc.gateway.dev/gettodo?userId=\(userId)")!
        }
        
        static func login() -> URL {
            return URL(string: "https://mytodolist-gateway-dhtwe5fo.uc.gateway.dev/login")!
        }
        
        static func signup() -> URL {
            return URL(string: "https://mytodolist-gateway-dhtwe5fo.uc.gateway.dev/adduser")!
        }
        
        static func addTask() -> URL {
            return URL(string: "https://mytodolist-gateway-dhtwe5fo.uc.gateway.dev/createtodo")!
        }
        
        static func udpateTask() -> URL {
            return URL(string: "https://mytodolist-gateway-dhtwe5fo.uc.gateway.dev/updatetodo")!
        }
        
        static func deleteTask(taskId : String) -> URL {
            return URL(string: "https://mytodolist-gateway-dhtwe5fo.uc.gateway.dev/deletetodo?id=\(taskId)")!
        }

    }
}
