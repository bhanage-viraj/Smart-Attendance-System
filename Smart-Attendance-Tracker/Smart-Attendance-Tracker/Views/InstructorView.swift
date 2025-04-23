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
        .navigationTitle("Instructor Panel")
    }
}

#Preview {
    InstructorView()
}



