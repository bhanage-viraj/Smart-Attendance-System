//
//  ContentView.swift
//  Smart-Attendance-Automation
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State private var opacity = 1.0
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        if isActive {
            LoginView()
        } else {
            VStack {
                // Logo image from second implementation
                Image("final-image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
                
                // Title text from second implementation
                Text("Smart Attendance \n        Automation")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 5)
            }
            .padding()
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                // First animation: fade out and scale down
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(.easeOut(duration: 1.6)) {
                        self.opacity = 0
                        self.scale = 0.5
                    }
                }
                
                // Transition to LoginView
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}