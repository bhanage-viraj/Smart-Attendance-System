import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
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
                        
                        TextField("Enter your SST email", text: $viewModel.email)
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
                                if viewModel.isSecured {
                                    SecureField("Enter your Password", text: $viewModel.password)
                                } else {
                                    TextField("Enter your Password", text: $viewModel.password)
                                }
                            }
                            .foregroundColor(textColor)
                            .textFieldStyle(DefaultTextFieldStyle())

                            Button(action: {
                                viewModel.isSecured.toggle()
                            }) {
                                Image(systemName: viewModel.isSecured ? "eye.slash" : "eye")
                                    .foregroundColor(secondaryTextColor)
                            }
                        }
                        .padding()
                        .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // Forgot password
                   
                    // Login button
                    Button(action: {
                        viewModel.login()
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else {
                            Text("Sign In")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Display error message if login fails
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                   
                    Button(action: {
                       
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
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
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





