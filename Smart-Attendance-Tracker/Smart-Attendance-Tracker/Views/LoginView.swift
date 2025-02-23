//
//  LoginView.swift
//  Smart-Attendance-Automation
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecured: Bool = true
    @State private var showAlert: Bool = false
    @State private var isLoggedIn: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var backgroundColor: Color {
        colorScheme == .dark ? Color.black : Color.white
    }
    
    var textColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    var secondaryTextColor: Color {
        colorScheme == .dark ? Color.gray : Color.gray
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 25) {
                    // Logo/Welcome section
                    VStack(spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                        
                        Text("Smart Attendance \n Automation")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(textColor)
                            .multilineTextAlignment(.center)
                        
                        Text("Please sign in to continue")
                            .font(.subheadline)
                            .foregroundColor(secondaryTextColor)
                    }
                    .padding(.top, 50)
                    
                    // Email field
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundColor(secondaryTextColor)
                        
                        TextField("Enter your SST email", text: $email)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(textColor)
                    }
                    .padding(.horizontal)
                    
                    // Password field
                    VStack(alignment: .leading) {
                        Text("Password")
                            .foregroundColor(secondaryTextColor)
                        
                        HStack {
                            Group {
                                if isSecured {
                                    SecureField("Enter your Password", text: $password)
                                        .textFieldStyle(DefaultTextFieldStyle())
                                } else {
                                    TextField("Enter your Password", text: $password)
                                        .textFieldStyle(DefaultTextFieldStyle())
                                }
                            }
                            .foregroundColor(textColor)
                            
                            Button(action: {
                                isSecured.toggle()
                            }) {
                                Image(systemName: isSecured ? "eye.slash" : "eye")
                                    .foregroundColor(secondaryTextColor)
                            }
                        }
                        .padding()
                        .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Forgot password
                    Button(action: {
                        // Handle forgot password
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                    }
                    
                    // Login button
                    Button(action: {
                        // Handle login
                        showAlert = true
                        isLoggedIn = true
                    }) {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // OR divider
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(secondaryTextColor.opacity(0.5))
                        
                        Text("OR")
                            .foregroundColor(secondaryTextColor)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(secondaryTextColor.opacity(0.5))
                    }
                    .padding(.horizontal)
                    
                    // Google Sign In button
                    Button(action: {
                        // Handle Google sign in
                    }) {
                        HStack {
                            Image(systemName: "g.circle.fill")
                                .foregroundColor(.red)
                            Text("Sign in with Google")
                                .fontWeight(.medium)
                        }
                        .foregroundColor(textColor)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(secondaryTextColor.opacity(0.5), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            
            .navigationDestination(isPresented: $isLoggedIn) {
                DashboardView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
