//
//  WebService.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/5/24.
//

import Foundation

enum NetworkError: Error, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
            lhs.value == rhs.value
        }
    var value: String? {
            return String(describing: self).components(separatedBy: "(").first
    }
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
    case duplicateEmailid
    case networkError(Error)
}

class WebService {
    
    func login(loginRequest: LoginRequest, completion: @escaping (Result<[User], Error>) -> Void) {
        var request = URLRequest(url: Constants.Urls.login())
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(loginRequest)
        } catch {
            print("Unable to encode request parameters")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
                guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
                
                // JSONDecoder() converts data to model of type Array
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                }
                catch {
                    completion(.failure(NetworkError.networkError(error)))
                }
            }.resume()
        }
    
    
    func dleteTodoItem(todoTaskId : String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        var request = URLRequest(url: Constants.Urls.deleteTask(taskId: todoTaskId))
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      
        URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
                guard let response = response as? HTTPURLResponse, 200 ... 409  ~= response.statusCode else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
        
                // JSONDecoder() converts data to model of type Array
                do {
                    let deletedTask = try JSONDecoder().decode(DeleteTaskResponse.self, from: data)
                    completion(.success(deletedTask.data ?? "000"))
                }
                catch {
                    completion(.failure(NetworkError.networkError(error)))
                }
                
            }.resume()
        }
    
    func updateTodoItem(todoTaskObj : TodoItem, completion: @escaping (Result<TodoItem, NetworkError>) -> Void) {
        var request = URLRequest(url: Constants.Urls.udpateTask())
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(todoTaskObj)
        } catch {
            print("Unable to encode request parameters")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
                guard let response = response as? HTTPURLResponse, 201 ... 409  ~= response.statusCode else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
        
                // JSONDecoder() converts data to model of type Array
                do {
                    let user = try JSONDecoder().decode(AddTaskResponse.self, from: data)
                    print(user.data)
                    completion(.success(user.data))
                }
                catch {
                    print("Response JSONDecoder error")
                    completion(.failure(NetworkError.networkError(error)))
                }
                
            }.resume()
        }
    
    func addTodoItem(todoTaskObj : TodoItem, completion: @escaping (Result<TodoItem, NetworkError>) -> Void) {
        var request = URLRequest(url: Constants.Urls.addTask())
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(todoTaskObj)
        } catch {
            print("Unable to encode request parameters")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
                guard let response = response as? HTTPURLResponse, 201 ... 409  ~= response.statusCode else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
        
                // JSONDecoder() converts data to model of type Array
                do {
                    let user = try JSONDecoder().decode(AddTaskResponse.self, from: data)
                    print(user.data)
                    completion(.success(user.data))
                }
                catch {
                    completion(.failure(NetworkError.networkError(error)))
                }
                
            }.resume()
        }
    
    func signup(signupRequestData: SignupRequest, completion: @escaping (Result<User, NetworkError>) -> Void) {
        var request = URLRequest(url: Constants.Urls.signup())
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(signupRequestData)
        } catch {
            print("Unable to encode request parameters")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
                guard let response = response as? HTTPURLResponse, 201 ... 409  ~= response.statusCode else {
                    completion(.failure(NetworkError.badResponse))
                    return
                }
            
                if(response.statusCode == 409) {
                    completion(.failure(NetworkError.duplicateEmailid))
                }else {
                    // JSONDecoder() converts data to model of type Array
                    do {
                        let user = try JSONDecoder().decode(SignupResponse.self, from: data)
                        print(user.data)
                        completion(.success(user.data))
                    }
                    catch {
                        completion(.failure(NetworkError.networkError(error)))
                    }
                }
            }.resume()
        }
    
    func fetchTodo(fromURL: URL) async throws -> [TodoItem] {
        let (data, response) = try await URLSession.shared.data(from: fromURL)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        do {
            return try JSONDecoder().decode([TodoItem].self, from: data)
        } catch {
            print(error)
            throw NetworkError.networkError(error)
        }
        
    }
    
    func fetchTodoV1<T: Codable>(fromURL: URL) async -> T? {
        do {
            let (data, response) = try await URLSession.shared.data(from: fromURL)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }

}
