//
//  LoginHandler.swift
//  SideProject
//
//  Created by Ankit.Gohel on 25/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import Foundation

class LoginHandler {
    var email   : String
    var password: String
    var username: String?
    let loginStatusHandler = LoginStatusHandler()
    let networkHandler: APIParser = APIParser()

    init(email: String, password: String, username: String?) {
        self.email = email
        self.password = password
        self.username = username
    }
    
    func requestLogin(completionHandler: @escaping (Result<UserModel, NetworkError>) -> Void) {
        networkHandler.registerUser(email: email,
                                    password: password,
                                    userName: nil) { result in
                                        switch result {
                                        case .success(let loggedInUserModel):
                                            completionHandler(.success(loggedInUserModel))
                                        case .failure(let error):
                                            completionHandler(.failure(error))
                                        }
        }
    }
    
    func requestSignUp(completionHandler: @escaping (Result<UserModel, NetworkError>) -> Void) {
        guard let _username = username else { return }
        networkHandler.registerUser(email: email,
                                    password: password,
                                    userName: _username) { result in
                                        switch result {
                                        case .success(let signedUpUserModel):
                                            completionHandler(.success(signedUpUserModel))
                                        case .failure(let error):
                                            completionHandler(.failure(error))
                                        }
        }
    }
}
