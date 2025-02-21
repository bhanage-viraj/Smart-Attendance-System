//
//  SuccessView.swift
//  Smart-Attendance-Automation
//


import SwiftUI

struct SuccessView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            // patatke fodne hai!!
            Text("Attendance Marked Successfully!")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("OK") {
                isPresented = false
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(width: 300, height: 150)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(isPresented: .constant(true))
    }
}
