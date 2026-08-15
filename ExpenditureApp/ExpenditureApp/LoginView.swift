//
//  LoginView.swift
//  ExpenditureApp
//
//  Created by VC on 23/07/26.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Keyboard Focus
    @FocusState private var focusedField: LoginField?
    
    enum LoginField {
        case email
        case password
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
                    Image("login")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 100)
                    
                    
                    VStack(
                        alignment: .leading,
                        spacing: 10
                    ) {
                        
                        Text("Expense Tracker")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Track your expenses anytime, anywhere.")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        
                        // MARK: - Email
                        
                        Text("Email")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        TextField(
                            "Enter your email",
                            text: $email
                        )
                        .padding()
                        .tint(.blue)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    Color.black.opacity(0.4),
                                    lineWidth: 1
                                )
                        )
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .focused(
                            $focusedField,
                            equals: .email
                        )
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .password
                        }
                        
                        
                        // MARK: - Password
                        
                        Text("Password")
                            .font(.headline)
                            .padding(.top, 20)
                        
                        SecureField(
                            "Enter your password",
                            text: $password
                        )
                        .padding()
                        .tint(.blue)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    Color.black.opacity(0.4),
                                    lineWidth: 1
                                )
                        )
                        .focused(
                            $focusedField,
                            equals: .password
                        )
                        .submitLabel(.done)
                        .onSubmit {
                            focusedField = nil
                        }
                        
                        
                        // MARK: - Login Button
                        
                        Button {
                            
                            // Hide keyboard
                            focusedField = nil
                            
                            let enteredEmail =
                                email.trimmingCharacters(
                                    in: .whitespacesAndNewlines
                                )
                            
                            let savedEmail =
                                KeychainManager.shared.read(
                                    forKey: "email"
                                )
                            
                            let savedPassword =
                                KeychainManager.shared.read(
                                    forKey: "password"
                                )
                            
                            
                            if enteredEmail.isEmpty {
                                
                                alertMessage =
                                    "Please enter your email."
                                
                                showAlert = true
                                
                            } else if password.isEmpty {
                                
                                alertMessage =
                                    "Please enter your password."
                                
                                showAlert = true
                                
                            } else if enteredEmail == savedEmail &&
                                      password == savedPassword {
                                
                                // Save login status
                                KeychainManager.shared.save(
                                    "true",
                                    forKey: "isLoggedIn"
                                )
                                
                                // Tell ContentView that login succeeded
                                NotificationCenter.default.post(
                                    name: Notification.Name("userDidLogin"),
                                    object: nil
                                )
                                
                            } else {
                                
                                alertMessage =
                                    "Invalid email or password."
                                
                                showAlert = true
                            }
                            
                        } label: {
                            
                            Text("Login")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(40)
                        }
                        .padding(.bottom, 20)
                        .alert(
                            alertMessage,
                            isPresented: $showAlert
                        ) {
                            
                            Button(
                                "OK",
                                role: .cancel
                            ) {
                                focusedField = nil
                            }
                        }
                        
                        
                        // MARK: - Sign Up
                        
                        Text("Don't have an account?")
                            .foregroundStyle(.black)
                        
                        NavigationLink("Sign Up") {
                            SignupView()
                        }
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundStyle(.blue)
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .padding(.horizontal, 30)
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}


#Preview {
    LoginView()
}
