//
//  AIChatBotView.swift
//  MoodMosaic
//
//  Created by Riya  on 4/28/25.
//

import SwiftUI

struct AIChatBotView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @ObservedObject var viewModel = EmotionAnalyzer()
    
    var body: some View {
        ZStack{
            Theme.background.ignoresSafeArea()
            VStack(spacing: 16) {
                Text("MoodyKares Chatbot")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.accent)
                    .shadow(color: Theme.accent.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 10)

                ScrollView {
                    Text(viewModel.responseText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Theme.chatbot)
                        .cornerRadius(10)
                        .foregroundColor(.primary)
                        .padding()
                }

                Spacer()

                VStack {
                    TextField("Say something...", text: $viewModel.userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button("Send") {
                        viewModel.sendMessage()
                    }
                    .buttonStyle(BlueButton())
                    
                    Button("Next") {
                        switchManager.setView(.startList)
                    }
                    .buttonStyle(BlueButton())
                }
                .padding(.bottom, 10)
            }
            .padding()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    AIChatBotView()
}
