//
//  QuoteView.swift
//  MoodMosaic
//
//  Created by Riya  on 4/29/25.
//

import SwiftUI

struct QuoteView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared
    
    let motivationalQuotes = [
        "\"Success is not final; failure is not fatal: It is the courage to continue that counts.\" —Winston Churchill",
        "\"It is better to fail in originality than to succeed in imitation.\" —Herman Melville",
        "\"The road to success and the road to failure are almost exactly the same.\" —Colin R. Davis",
        "\"Success usually comes to those who are too busy to be looking for it.\" —Henry David Thoreau",
        "\"Develop success from failures. Discouragement and failure are two of the surest stepping stones to success.\" —Dale Carnegie",
        "\"Nothing in the world can take the place of persistence. Talent will not; nothing is more common than unsuccessful men with talent. Genius will not; unrewarded genius is almost a proverb. Education will not; the world is full of educated derelicts. The slogan ‘Press On’ has solved and always will solve the problems of the human race.\" —Calvin Coolidge",
        "\"There are three ways to ultimate success: The first way is to be kind. The second way is to be kind. The third way is to be kind.\" —Mister Rogers",
        "\"Success is peace of mind, which is a direct result of self-satisfaction in knowing you made the effort to become the best of which you are capable.\" —John Wooden",
        "\"I never dreamed about success. I worked for it.\" —Estée Lauder",
        "\"Success is getting what you want; happiness is wanting what you get.\" ―W. P. Kinsella"
    ]
    var body: some View {
        ZStack{
            Theme.background
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("✨ Daily Inspiration ✨")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.accent)
                            .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                
                Text(getTodaysQuote())
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                
                Button("Next"){
                    switchManager.setView(.moodTracker)
                }
                .buttonStyle(BlueButton())
                
                Spacer()
                
                Button("Terms and Conditions"){
                    switchManager.setView(.termsAndConditions)
                }
                
                Text("Note: This app is not meant to treat any form\nof mental illness. If you or someone you know is struggling, please reach out to a mental health professional.")
                    .padding(.bottom, 40)
                
            }
        }
    }
    func getTodaysQuote() -> String {
            let calendar = Calendar.current
            let dayOfYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 0
            let index = dayOfYear % motivationalQuotes.count
            return motivationalQuotes[index]
    }
    
}

#Preview {
    QuoteView()
}
