//
//  EmotionAnalyzer.swift
//  MoodMosaic
//
//  Created by Riya on 4/30/25.
//

import Foundation
import Ollama

@MainActor
class EmotionAnalyzer: ObservableObject {
    @Published var userInput: String = ""
    @Published var messages: [Message] = []
    @Published var isLoading: Bool = false
    
    private let client = Client.default
    private let modelID: Model.ID = "smollm:360m"
    
    init() {
        messages.append(Message(content: "Hello! How can I help you today?", isUser: false))
    }
    
    func sendMessage() {
        guard !userInput.isEmpty else { return }
        
        let userMessageContent = userInput
        messages.append(Message(content: userMessageContent, isUser: true))
        userInput = ""
        isLoading = true
        
        let botMessageIndex = messages.count
        messages.append(Message(content: "", isUser: false))
        
        Task {
            do {
                let chatHistory = messages.map { msg -> Ollama.Chat.Message in
                    msg.isUser ? .user(msg.content) : .assistant(msg.content)
                }
                
                let stream = try await client.chatStream(
                    model: modelID,
                    messages: chatHistory,
                    options: [
                        "temperature": 0.7,
                        "num_ctx": 400
                    ]
                )
                
                var fullResponse = ""
                for try await chunk in stream {
                    fullResponse += chunk.message.content
                    DispatchQueue.main.async {
                        self.messages[botMessageIndex].content = fullResponse
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.messages[botMessageIndex].content = "Error: \(error.localizedDescription)"
                }
                print("Error generating response: \(error)")
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}



struct Message: Identifiable, Equatable {
    let id = UUID()
    var content: String
    let isUser: Bool
}
