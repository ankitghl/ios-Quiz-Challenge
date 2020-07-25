//
//  AppUserDefaultExtension.swift
//  SideProject
//
//  Created by Ankit.Gohel on 25/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import Foundation

public enum LoginState {
    case preLogin
    case instructions
    case loggedIn
}

class LoginStatusHandler: ObservableObject {
    @Published var loginStatus = {
        return UserDefaults.standard.userLoginStatus
    }()
    
    init() { }
    
    func setLoginStatus(status: LoginState) {
        loginStatus = status
        UserDefaults.standard.userLoginStatus = status
    }
}

extension UserDefaults {
    /// Store region identifier for cache purpose.
     public var userLoginStatus: LoginState {
        get {
            var userStatus: LoginState = .preLogin
            if !self.logInStatus() {
                userStatus = .preLogin
            } else {
                if !self.instructionsViewedStatus() {
                    userStatus = .instructions
                }
                userStatus = .loggedIn
            }
            return userStatus
        }
        set {
            if newValue == .loggedIn {
                self.set(logIn: true)
                self.set(instructions: true)
            } else if newValue == .instructions {
                self.set(logIn: true)
                self.set(instructions: false)
            } else {
                self.set(logIn: false)
                self.set(instructions: false)
            }
        }
    }
}

// MARK: - Internal Helper API of UserDefault.
fileprivate extension UserDefaults {
    static let loggedIn = "isLoggedIn"
    static let instructionsViewed = "isInstructionRead"

    /// Setter: Save Log In Status in UserDefault with `isLoggedIn` key.
    ///
    /// - Parameter value: Bool.
    func set(logIn value: Bool) {
        self.set(value, forKey: UserDefaults.loggedIn)
        self.synchronize()
    }
    
    /// Getter: Get Log In Status from UserDefault.
    ///
    /// - Returns: Log In Bool, saved in UserDefault with `isLoggedIn` key.
    func logInStatus() -> Bool {
        return (self.value(forKey: UserDefaults.loggedIn) != nil)
    }
    
    /// Setter: Save Instruction Viewed Status in UserDefault with `isInstructionRead` key.
    ///
    /// - Parameter value: Bool.
    func set(instructions value: Bool) {
        self.set(value, forKey: UserDefaults.instructionsViewed)
        self.synchronize()
    }
    
    /// Getter: Get Instruction Viewed Status from UserDefault.
    ///
    /// - Returns: Instruction Viewed Bool, saved in UserDefault with `isInstructionRead` key.
    func instructionsViewedStatus() -> Bool {
        return (self.value(forKey: UserDefaults.instructionsViewed) != nil)
    }

    
}
