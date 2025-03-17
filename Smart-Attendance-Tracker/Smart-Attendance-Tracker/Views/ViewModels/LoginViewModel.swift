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
    
    
    
    func login () {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password"
            return
        }
        isLoading = true
        // to call authservice
        
    }
    
}
