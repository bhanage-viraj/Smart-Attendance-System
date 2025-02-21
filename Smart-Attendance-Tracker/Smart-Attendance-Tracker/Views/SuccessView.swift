//
//  SuccessView.swift
//  Smart-Attendance-Automation
//

import SwiftUI

struct SuccessView: View {
    @Binding var isPresented: Bool
    @State private var confettiCounter = 0
    @State private var showStars = false
    @State private var showText = false
    @State private var bounce = false
    
    var body: some View {
        ZStack {
            
            // Background with stars
            ForEach(0..<30) { index in
                Circle()
                    .fill(Color.yellow)
                    .frame(width: CGFloat.random(in: 3...6))
                    .position(
                        x: CGFloat.random(in: 0...300),
                        y: CGFloat.random(in: 0...300)
                    )
                    .scaleEffect(showStars ? 1 : 0)
                    .opacity(showStars ? 0.8 : 0)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .delay(Double(index) * 0.05),
                        value: showStars
                    )
            }
            
            // Confetti
            ForEach(0..<50) { index in
                ConfettiPiece(index: index, counter: confettiCounter)
            }
            
            // Main content
            VStack {
                Text("Attendance Marked Successfully!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .scaleEffect(showText ? 1.1 : 0.5)
                    .opacity(showText ? 1 : 0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: showText)
                
                Spacer().frame(height: 30)
                
                Button("AWESOME!") {
                    isPresented = false
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .scaleEffect(bounce ? 1.1 : 1.0)
                .animation(
                    Animation.spring(response: 0.4, dampingFraction: 0.6)
                        .repeatCount(5, autoreverses: true),
                    value: bounce
                )
            }
            .frame(width: 300, height: 200)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.7)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 2)
            )
            .shadow(color: Color.purple.opacity(0.5), radius: 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.7))
        .onAppear {
            // Start animations in sequence
            withAnimation {
                confettiCounter += 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showStars = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                showText = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                bounce = true
            }
        }
    }
}

// Confetti piece
struct ConfettiPiece: View {
    let index: Int
    let counter: Int
    
    @State private var position = CGPoint(x: 0, y: 0)
    @State private var rotation = Double.random(in: 0...360)
    @State private var scale: CGFloat = 0.01
    @State private var opacity: Double = 0
    
    var body: some View {
        let colors: [Color] = [.red, .blue, .green, .yellow, .pink, .purple, .orange]
        let shapes = ["■", "●", "★", "✦", "♦", "▲", "✶"]
        
        Text(shapes[index % shapes.count])
            .font(.system(size: CGFloat.random(in: 15...30)))
            .foregroundColor(colors[index % colors.count])
            .rotationEffect(.degrees(rotation))
            .position(position)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                // Random starting position at the bottom
                position = CGPoint(
                    x: CGFloat.random(in: 50...250),
                    y: 400
                )
                
                // Animate to a random position above
                withAnimation(
                    Animation.timingCurve(0.1, 0.8, 0.2, 1, duration: Double.random(in: 2.0...4.0))
                ) {
                    position = CGPoint(
                        x: CGFloat.random(in: 0...300),
                        y: CGFloat.random(in: -50...150)
                    )
                    rotation += Double.random(in: 180...720)
                    scale = CGFloat.random(in: 0.7...1.3)
                    opacity = Double.random(in: 0.5...1.0)
                    
                    // Fade out at the end
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            opacity = 0
                        }
                    }
                }
            }
            // Counter change triggers animation restart
            .id("\(index)-\(counter)")
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(isPresented: .constant(true))
    }
}
