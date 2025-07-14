//
//  IntroAIView.swift
//  MoodMosaic
//
//  Created by Riya  on 4/28/25.
//

import SwiftUI


struct IntroAIView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        ZStack{
            Theme.background
                .ignoresSafeArea()
            
            VStack{
                
                Text("Unsure how you're feeling today?")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.accent)
                            .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.top, 40)
                    .padding(.horizontal)
                
                ScrollView(){
                    Text("Let MoodyKares, our AI Chatbot, help you out! \n\n 1. Explain your current situation or certain conditions to MoodyKares. \n\n2. MoodyKares will then provide you with a list of suggestions or activities to help you feel better. \n\n3. Take a look at the suggestions and choose one that you feel most comfortable with trying out in the activities page.")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(isDarkMode ? .white : .black)
                        .padding(.bottom, 50)
                        .padding(.top, 30)
                        .padding(.horizontal, 30)
                }
                Button("To MoodyKares!"){
                    switchManager.setView(.aibot)
                }
                .buttonStyle(BlueButton())
            
            }
        }
    }
}

#Preview {
    IntroAIView()
}
