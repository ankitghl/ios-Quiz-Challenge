//
//  APIParser.swift
//  SideProject
//
//  Created by Ankit.Gohel on 12/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case badResponse
    case badResponseData
    case failureResponse
}

class APIParser {
    let baseURL: String = "https://7cc3c3799a85.ngrok.io"
    
    func registerUser(email: String, password: String, userName: String?, completionHandler:  @escaping (Result<UserModel, NetworkError>) -> Void) {
        var apiPath = "/login"
        var parameters: [String: Any] = [
            "password": password,
            "email": email
        ]
        
        if let _username = userName {
            parameters["username"] = _username
            apiPath = "/signup"
        }
        
        guard let url = URL(string: "\(baseURL)\(apiPath)") else {
            completionHandler(.failure(.badURL))
            return
        }
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            completionHandler(.failure(.badRequest))
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.badResponse))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let user = try decoder.decode(UserResponseModel.self, from: data)
                if user.success {
                    completionHandler(.success(user.data))
                    return
                } else {
                    completionHandler(.failure(.failureResponse))
                }
            } catch {
                completionHandler(.failure(.badResponseData))
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getGameInstructions(completionHandler: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/instructions") else {
            completionHandler(.failure(.badURL))
            return
        }
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.badResponse))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let instructions = try decoder.decode(InstructionResponseModel.self, from: data)
                if instructions.success {
                    completionHandler(.success(instructions.data))
                } else {
                    completionHandler(.failure(.failureResponse))
                }
            } catch {
                completionHandler(.failure(.badResponseData))
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
