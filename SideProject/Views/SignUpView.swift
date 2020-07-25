//
//  SignUpView.swift
//  SideProject
//
//  Created by Ankit.Gohel on 04/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var shouldAnimate = false

    var body: some View {
        VStack() {
            Text("SignUp")
                .font(.title).foregroundColor(Color.white)
                .shadow(radius: 10.0, x: 20, y: 10)
            
            Image("iosapptemplate")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10.0, x: 20, y: 10)
                .padding(.bottom, 50)
                .padding(.top, 30)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Username", text: self.$username)
                    .padding()
                    .frame(height: 40)
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .textContentType(.username)

                TextField("Email", text: self.$email)
                    .padding()
                    .frame(height: 40)
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)

                SecureField("Password", text: self.$password)
                    .padding()
                    .frame(height: 40)
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .textContentType(.password)
                
                SecureField("Confirm Password", text: self.$confirmPassword)
                    .padding()
                    .frame(height: 40)
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .textContentType(.password)

            }.padding([.leading, .trailing], 27.5)
            
            ActivityIndicator(shouldAnimate: $shouldAnimate)

            Button(action: {
                guard self.username.handleTextInput(for: .username) else {
                    self.showAlert = true
                    self.alertMessage = "Please enter valid Username"
                    return
                }
                guard self.email.handleTextInput(for: .email) else {
                    self.showAlert = true
                    self.alertMessage = "Please enter valid Email"
                    return
                }
                guard self.password.handleTextInput(for: .password) else {
                    self.showAlert = true
                    self.alertMessage = "Please enter valid Password"
                    return
                }
//                guard self.password == self.confirmPassword else {
//                    self.showAlert = true
//                    self.alertMessage = "Password and Confirm Password does not match"
//                    return
//                }
                self.shouldAnimate = true
                let loginHandler = LoginHandler(email: self.email,
                                                password: self.password,
                                                username: self.username)
                loginHandler.requestSignUp { result in
                    self.shouldAnimate = false
                    switch result {
                    case .success(let signedInUser):
                        print(signedInUser)
                    case .failure(let error):
                        print(error)
                    }
                }
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 40)
                    .background(Color.green)
                    .cornerRadius(20)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 30)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Quiz Challenges"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
            }

            Spacer()
        }.background(
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
            .navigationBarTitle("", displayMode: .inline)
            .keyboardAdaptive()
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
