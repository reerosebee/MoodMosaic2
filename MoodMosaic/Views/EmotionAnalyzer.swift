//
//  EmotionAnalyzer.swift
//  MoodMosaic
//
//  Created by Riya  on 4/30/25.
//

import Foundation

class EmotionAnalyzer: ObservableObject {
    @Published var userInput: String = ""
    @Published var responseText: String = "Hi! My name is MoodyKares! How can I help you?"
    @Published var conversation: [String] = []

    func sendMessage() {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "HUGGINGFACE_API_KEY") as? String else {
            print("Hugging Face API token is missing.")
            return
        }

        let url = URL(string: "https://api-inference.huggingface.co/models/mistralai/Mixtral-8x7B-Instruct-v0.1")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let userMessage = "User: \(userInput)"
        conversation.append(userMessage)

        
        let prompt = (conversation + ["Bot:"]).joined(separator: "\n")

        let body: [String: Any] = ["inputs": prompt]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.responseText = "Oops! Something went wrong."
                }
                return
            }

            if let decoded = try? JSONDecoder().decode([HuggingFaceResponse].self, from: data),
               let generatedText = decoded.first?.generated_text {
                
                let reply = generatedText.components(separatedBy: "Bot:").last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? generatedText

                DispatchQueue.main.async {
                    self.conversation.append("Bot: \(reply)")
                    self.responseText = self.conversation.joined(separator: "\n\n")
                    self.userInput = ""
                }
            } else {
                DispatchQueue.main.async {
                    self.responseText = "Sorry, I didn’t quite get that."
                }
            }
        }.resume()
    }
}

struct HuggingFaceResponse: Codable {
    let generated_text: String
}
