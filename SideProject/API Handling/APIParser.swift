//
//  APIParser.swift
//  SideProject
//
//  Created by Ankit.Gohel on 12/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import Foundation

let baseURL: String = "https://58e786484ec8.ngrok.io"

func registerUser(userName: String?, password: String, email: String, completionHandler: @escaping (UserModel) -> Void) {
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
        print(error.localizedDescription)
    }

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        guard error == nil else {
            return
        }
        
        guard let data = data else {
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let user = try decoder.decode(UserResponseModel.self, from: data)
            completionHandler(user.data)
        } catch {
            print(error.localizedDescription)
        }
    })
    task.resume()
}

func getGameInstructions(completionHandler: @escaping (String) -> Void) {
    guard let url = URL(string: "\(baseURL)/instructions") else {
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
            return
        }
        
        guard let data = data else {
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let instructions = try decoder.decode(InstructionResponseModel.self, from: data)
            completionHandler(instructions.data)
        } catch {
            print(error.localizedDescription)
        }
    })
    task.resume()

}
