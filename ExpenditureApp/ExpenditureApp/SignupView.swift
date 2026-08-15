//
//  SignupView.swift
//  ExpenditureApp
//
//  Created by VC on 24/07/26.
//
import SwiftUI

struct SignupView: View {
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var goToHome = false
    
    @Environment(\.dismiss) private var dismiss
    
    
    // MARK: - Keyboard Focus
    
    @FocusState private var focusedField: SignupField?
    
    enum SignupField {
        case fullName
        case email
        case password
        case confirmPassword
    }
    
    
    var body: some View {
        
        VStack(
            alignment: .leading,
            spacing: 25
        ) {
            
            // MARK: - Title
            
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            
            Spacer()
            
            
            // MARK: - Full Name
            
            Text("Full Name")
                .font(.headline)
            
            TextField(
                "Enter your full name",
                text: $fullName
            )
            .padding()
            .tint(.blue)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.black.opacity(0.4),
                        lineWidth: 1
                    )
            )
            .focused(
                $focusedField,
                equals: .fullName
            )
            .submitLabel(.next)
            .onSubmit {
                focusedField = .email
            }
            
            
            // MARK: - Email
            
            Text("Email")
                .font(.headline)
            
            TextField(
                "Enter your email",
                text: $email
            )
            .padding()
            .tint(.blue)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
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
            
            SecureField(
                "Enter your password",
                text: $password
            )
            .padding()
            .tint(.blue)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.black.opacity(0.4),
                        lineWidth: 1
                    )
            )
            .focused(
                $focusedField,
                equals: .password
            )
            .submitLabel(.next)
            .onSubmit {
                focusedField = .confirmPassword
            }
            
            
            // MARK: - Confirm Password
            
            Text("Confirm Password")
                .font(.headline)
            
            SecureField(
                "Confirm your password",
                text: $confirmPassword
            )
            .padding()
            .tint(.blue)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.black.opacity(0.4),
                        lineWidth: 1
                    )
            )
            .focused(
                $focusedField,
                equals: .confirmPassword
            )
            .submitLabel(.done)
            .onSubmit {
                focusedField = nil
            }
            
            
            // MARK: - Create Account
            
            Button {
                
                // Hide keyboard
                focusedField = nil
                
                let trimmedName =
                    fullName.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )
                
                let trimmedEmail =
                    email.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )
                
                
                // MARK: - Validation
                
                if trimmedName.isEmpty {
                    
                    alertMessage =
                        "Please enter your full name."
                    showAlert = true
                    
                } else if trimmedEmail.isEmpty {
                    
                    alertMessage =
                        "Please enter your email."
                    showAlert = true
                    
                } else if !trimmedEmail.contains("@") ||
                            !trimmedEmail.contains(".") {
                    
                    alertMessage =
                        "Please enter a valid email address."
                    showAlert = true
                    
                } else if password.isEmpty {
                    
                    alertMessage =
                        "Please enter your password."
                    showAlert = true
                    
                } else if confirmPassword.isEmpty {
                    
                    alertMessage =
                        "Please confirm your password."
                    showAlert = true
                    
                } else if password != confirmPassword {
                    
                    alertMessage =
                        "Passwords do not match."
                    showAlert = true
                    
                } else {
                    
                    // MARK: - Save Account
                    
                    KeychainManager.shared.save(
                        trimmedName,
                        forKey: "fullName"
                    )
                    
                    KeychainManager.shared.save(
                        trimmedEmail,
                        forKey: "email"
                    )
                    
                    KeychainManager.shared.save(
                        password,
                        forKey: "password"
                    )
                    
                    // New account is automatically logged in
                    KeychainManager.shared.save(
                        "true",
                        forKey: "isLoggedIn"
                    )
                    
                    // Show success message
                    alertMessage =
                        "Account created successfully!"
                    
                    showAlert = true
                }
                
            } label: {
                
                Text("Create Account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(90)
            }
            
            
            // MARK: - Login
            
            HStack {
                
                Text("Already have an account?")
                
                Button {
                    focusedField = nil
                    dismiss()
                    
                } label: {
                    
                    Text("Login")
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
            
            
            Spacer()
        }
        .padding()
        
        
        // MARK: - Success / Validation Alert
        
        .alert(
            alertMessage,
            isPresented: $showAlert
        ) {
            
            Button("OK") {
                
                focusedField = nil
                
                if alertMessage ==
                    "Account created successfully!" {
                    
                    // Go directly to Home
                    goToHome = true
                }
            }
        }
        
        
        // MARK: - Go To Home
        
        .navigationDestination(
            isPresented: $goToHome
        ) {
            HomeViewNew()
        }
        
        
        // MARK: - Background
        
        .background(
            LinearGradient(
                colors: [
                    Color.cyan.opacity(0.35),
                    Color.blue.opacity(0.25)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}


#Preview {
    SignupView()
}
