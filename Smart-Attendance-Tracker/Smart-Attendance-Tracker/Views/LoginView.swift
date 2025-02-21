//
//  LoginView.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 18/02/25.
//

import SwiftUI

struct LoginView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // edit code here
                
                Button(action: {
                    isLoggedIn = true
                }) {
                    Text("Login")
                    // just change css code faad na nahi hai!!
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                
                // NavigationLink to DashboardView
                NavigationLink(destination: DashboardView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
