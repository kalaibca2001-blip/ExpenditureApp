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
    
    @State private var goToHome = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            
                VStack(spacing: 0) {

                    Image("login")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 100)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Expense Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                       
                    Text("Track your expenses anytime, anywhere.")
                        .font(.subheadline)
                    
                        .foregroundStyle(.gray)
                    Text("Email")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black.opacity(0.4), lineWidth: 1)
                        )
                    
                    Text("Password")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black.opacity(0.4), lineWidth: 1)
                        )
                   
                    
                    Button {
                        
                        let enteredEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        let savedEmail = KeychainManager.shared.read(forKey: "email")
                        let savedPassword = KeychainManager.shared.read(forKey: "password")
                        
                        if enteredEmail.isEmpty {
                            
                            alertMessage = "Please enter your email."
                            showAlert = true
                            
                        } else if password.isEmpty {
                            
                            alertMessage = "Please enter your password."
                            showAlert = true
                            
                        } else if enteredEmail == savedEmail && password == savedPassword {
                            
                            goToHome = true
                            
                        } else {
                            
                            print("Saved Email:", savedEmail ?? "nil")
                            print("Entered Email:", enteredEmail)
                            print("Password exists:", savedPassword != nil)
                            
                            alertMessage = "Invalid email or password."
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
                    
                    .alert(alertMessage, isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    
                    Text("Don't have an account?")
                        .foregroundStyle(.black)
                    
                    NavigationLink("Sign Up") {
                        SignupView()
                    }
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundStyle(.blue)
                    
                }
               
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                Spacer()
                .padding(.top, 70)
                
                Spacer()
                
            }
            
                .navigationDestination(isPresented: $goToHome) {
                       HomeViewNew()
                   }
        }
        
        
    }
    
}
    #Preview {
        LoginView()
    }

