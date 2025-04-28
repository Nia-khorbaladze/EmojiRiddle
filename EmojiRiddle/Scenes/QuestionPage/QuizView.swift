//
//  QuizView.swift
//  EmojiRiddle
//
//  Created by Nkhorbaladze on 27.12.24.
//

import SwiftUI

struct QuizView: View {
    var options: [String]
    var onOptionSelected: (String) -> Void

    var body: some View {
        VStack(spacing: 16) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    onOptionSelected(option)
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(hexString: "FFDAF9")))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        .background(Color(UIColor(hexString: "100735")).edgesIgnoringSafeArea(.all)) 
    }
}
