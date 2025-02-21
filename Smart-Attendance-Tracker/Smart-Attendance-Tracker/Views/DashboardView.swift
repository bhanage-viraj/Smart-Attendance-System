//
//  DashboardView.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 18/02/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            Button(action: {
                print("Attendance Marked")
            }) {
                Text("Mark Attendance")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
