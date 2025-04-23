//
//  InstructorView.swift
//  Smart-Attendance-Tracker
//
//  Created by Aryan Raju Kahate on 23/04/25.
//
import SwiftUI

struct InstructorView: View {
    @State private var isAttendanceActive = false

    var body: some View {
        VStack {
           
            Text("Welcome to the Instructor Panel")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.black)
                .cornerRadius(10)

            Spacer()

            
            Image("InstructorIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            

            Spacer()

            
            Button(action: {
                isAttendanceActive.toggle()
            }) {
                Text(isAttendanceActive ? "Stop Attendance" : "Start Attendance")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220)
                    .background(isAttendanceActive ? Color.red : Color.blue.opacity(0.7))
                    .cornerRadius(12)
                    .animation(.easeInOut, value: isAttendanceActive)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Instructor Panel")
    }
}

#Preview {
    InstructorView()
}




