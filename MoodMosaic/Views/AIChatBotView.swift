//
//  AIChatBotView.swift
//  MoodMosaic
//
//  Created by Riya  on 4/28/25.
//

import SwiftUI

struct AIChatBotView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @StateObject var viewModel = EmotionAnalyzer()
    @State private var scrollViewProxy: ScrollViewProxy?

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 16) {
                Text("MoodyKares Chatbot")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.accent)
                    .shadow(color: Theme.accent.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 10)

                ScrollView {
                    ScrollViewReader { proxy in
                        LazyVStack(alignment: .leading, spacing: 8) {
                            ForEach(viewModel.messages) { message in
                                ChatBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .onAppear {
                            self.scrollViewProxy = proxy
                            scrollToBottom()
                        }
                        .onChange(of: viewModel.messages.count) { _ in
                            scrollToBottom()
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

                VStack {
                    TextField("Say something...", text: $viewModel.userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button("Send") {
                        viewModel.sendMessage()
                    }
                    .buttonStyle(BlueButton())
                    .disabled(viewModel.isLoading || viewModel.userInput.isEmpty)

                    Button("Next") {
                        switchManager.setView(.startList)
                    }
                    .buttonStyle(BlueButton())
                }
                .padding(.bottom, 10)
            }
            .padding(.top)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private func scrollToBottom() {
        if let lastMessage = viewModel.messages.last {
            withAnimation {
                scrollViewProxy?.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
}

struct ChatBubble: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }

            Text(message.content)
                .padding(10)
                .background(message.isUser ? Theme.accent.opacity(0.8) : Theme.chatbot) // Different background for user/bot
                .foregroundColor(message.isUser ? .white : .primary)
                .cornerRadius(15)
                .shadow(radius: 1)
            
            if !message.isUser {
                Spacer()
            }
        }
    }
}

#Preview {
    AIChatBotView()
}
