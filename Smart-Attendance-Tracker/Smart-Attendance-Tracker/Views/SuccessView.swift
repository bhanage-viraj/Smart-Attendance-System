//
//  SuccessView.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 18/02/25.
//

//
//  SuccessView.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 18/02/25.
//

import SwiftUI

struct SuccessView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Attendance Marked Successfully!")
                .font(.title2)
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
