//
//  ContentView.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 17/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToLogin = false
    
    var body: some View {
        VStack {
            if navigateToLogin {
                LoginView()
            } else {
                Text("Logo")
                    .font(.largeTitle)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            navigateToLogin = true
                        }
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
