//
//  DashboardView.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 18/02/25.
//

import SwiftUI

struct DashboardView: View {
    @State private var showSuccessPopup = false

    var body: some View {
        
        ZStack {
            VStack {
                // edit code here
                //  make a dashboard
                
                
                Button(action: {
                    showSuccessPopup = true
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

            
            if showSuccessPopup {
                SuccessView(isPresented: $showSuccessPopup)
                    .transition(.scale)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
