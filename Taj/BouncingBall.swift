//
//  BouncingBall.swift
//  Taj
//
//  Created by Pavankumar Arepu on 17/07/23.
//

import SwiftUI
import Combine

struct Ball: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGVector
    var color: Color
}

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}

struct BouncingBallsView: View {
    @State private var balls: [Ball] = []
    private let timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ForEach(balls) { ball in
                Circle()
                    .fill(ball.color.opacity(0.8))
                    .frame(width: 50, height: 50)
                    .position(ball.position)
            }
        }
        .onAppear {
            createBalls(count: 5)
        }
        .onReceive(timer) { _ in
            updateBallPositions()
        }
    }
    
    func createBalls(count: Int) {
        var newBalls: [Ball] = []
        
        for _ in 0..<count {
            let randomX = CGFloat.random(in: 0..<UIScreen.main.bounds.width)
            let randomY = CGFloat.random(in: 0..<UIScreen.main.bounds.height)
            let randomVelocityX = CGFloat.random(in: -5...5)
            let randomVelocityY = CGFloat.random(in: -5...5)
            let randomColor = Color.random()
            let ball = Ball(position: CGPoint(x: randomX, y: randomY), velocity: CGVector(dx: randomVelocityX, dy: randomVelocityY), color: randomColor)
            newBalls.append(ball)
        }
        
        balls = newBalls
    }
    
    func updateBallPositions() {
        balls = balls.map { ball in
            var updatedBall = ball
            updatedBall.position.x += updatedBall.velocity.dx
            updatedBall.position.y += updatedBall.velocity.dy
            
            if updatedBall.position.x + 25 >= UIScreen.main.bounds.width || updatedBall.position.x - 25 <= 0 {
                updatedBall.velocity.dx *= -1
            }
            
            if updatedBall.position.y + 25 >= UIScreen.main.bounds.height || updatedBall.position.y - 25 <= 0 {
                updatedBall.velocity.dy *= -1
            }
            
            for otherBall in balls where otherBall.id != updatedBall.id {
                let distance = hypot(updatedBall.position.x - otherBall.position.x, updatedBall.position.y - otherBall.position.y)
                if distance < 50 {
                    let randomVelocityX = CGFloat.random(in: -5...5)
                    let randomVelocityY = CGFloat.random(in: -5...5)
                    updatedBall.velocity = CGVector(dx: randomVelocityX, dy: randomVelocityY)
                }
            }
            
            return updatedBall
        }
    }
}

struct BouncingBallsView_Previews: PreviewProvider {
    static var previews: some View {
        BouncingBallsView()
    }
}
