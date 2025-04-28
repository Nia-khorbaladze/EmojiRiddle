//
//  ResultsView.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import SwiftUI

struct ResultsView: View {
    let isWin: Bool

    var body: some View {
        ZStack {
            Color(uiColor: UIColor(hexString: "100735"))
                .ignoresSafeArea(.all)
            if isWin {
                Text("🎉 Congratulations! You Win! 🎉")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hexString: "FFDAF9")))
                ConfettiAnimationView()
            } else {
                Text("☹️ Better Luck Next Time! ☹️")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hexString: "FFDAF9")))
                SadFaceAnimationView()
            }
        }
    }
}
