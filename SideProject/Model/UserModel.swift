//
//  UserModel.swift
//  SideProject
//
//  Created by Ankit.Gohel on 12/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

struct UserResponseModel: Codable {
    public let success: Bool
    public let message: String
    public let data: UserModel
}

struct UserModel: Codable {
    public let id       :   String
    public let username :   String?
    public let password :   String?
    public let email    :   String?
    
    init() {
        id = ""
        username = ""
        password = ""
        email = ""
    }
}
