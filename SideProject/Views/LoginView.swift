//
//  ContentView.swift
//  SideProject
//
//  Created by Ankit.Gohel on 28/06/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isNavigationBarHidden: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    init() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        NavigationView {
            VStack() {
                Text("Quiz Challenge")
                    .font(.largeTitle).foregroundColor(Color.white)
                    .padding([.top, .bottom], 20)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                Image("iosapptemplate")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: self.$email)
                        .padding()
                        .frame(height: 40)
                        .background(Color.themeTextField)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                    
                    SecureField("Password", text: self.$password)
                        .padding()
                        .frame(height: 40)
                        .background(Color.themeTextField)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding([.leading, .trailing], 27.5)
                
                
                Button(action: {
                    guard self.email.handleTextInput(for: .email) else {
                        self.showAlert = true
                        self.alertMessage = "Please enter valid Email"
                        return
                    }
//                    guard self.password.handleTextInput(for: .password) else {
//                        self.showAlert = true
//                        self.alertMessage = "Please enter valid Password"
//                        return
//                    }
                    let loginHandler = LoginHandler(email: self.email,
                                                    password: self.password,
                                                    username: nil)
                    loginHandler.requestLogin { result in
                        switch result {
                        case .success(let loggedInUser):
                            print(loggedInUser)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }) {
                    Text("Sign In")
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
                HStack(spacing: 0) {
                    Text("Don't have an account? ")
                    Button(action: {
                    }) {
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .foregroundColor(.black)
                        }
                    }
                }.padding()
            } .background(
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
                .keyboardAdaptive()
                .navigationBarTitle("")
                .navigationBarHidden(self.isNavigationBarHidden)
                .onAppear {
                    self.isNavigationBarHidden = true
            }
            .onDisappear{
                self.isNavigationBarHidden = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
