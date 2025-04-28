//
//  AnimationView.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import SwiftUI

struct ConfettiAnimationView: View {
    @State private var animateParticles = false

    var body: some View {
        ZStack {
            ForEach(0..<50) { index in
                Circle()
                    .fill(Color.random)
                    .frame(width: 10, height: 10)
                    .position(x: CGFloat.random(in: 0...300),
                              y: animateParticles ? 800 : CGFloat.random(in: -200...0)) 
                    .animation(
                        Animation.easeOut(duration: 2)
                            .delay(Double(index) * 0.05),
                        value: animateParticles
                    )
            }
        }
        .onAppear {
            animateParticles = true
        }
    }
}

struct SadFaceAnimationView: View {
    @State private var animateParticles = false

    var body: some View {
        ZStack {
            ForEach(0..<50) { index in
                Text("☹️")
                    .font(.largeTitle)
                    .position(x: CGFloat.random(in: 0...300), y: animateParticles ? 800 : -50)
                    .animation(
                        Animation.easeIn(duration: 2)
                            .delay(Double(index) * 0.05),
                        value: animateParticles
                    )
            }
        }
        .onAppear {
            animateParticles = true
        }
    }
}

