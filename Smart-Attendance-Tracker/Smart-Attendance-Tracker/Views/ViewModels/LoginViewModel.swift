//
//  LoginViewModel.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 17/03/25.
//




import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    @Published var isSecured: Bool = true
    
    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password"
            return
        }
        
        isLoading = true
        
      
        AuthService.shared.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let token):
                    self?.isLoggedIn = true
                    UserDefaults.standard.set(token, forKey: "jwt_token")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
