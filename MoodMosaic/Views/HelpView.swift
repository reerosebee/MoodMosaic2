//
//  HelpView.swift
//  MoodMosaic
//
//  Created by Riya  on 5/4/25.
//

import SwiftUI

struct HelpView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared
    
    var body: some View {
        ZStack{
            Theme.background
                .ignoresSafeArea()
            VStack{
                Text("Welcome to MoodMosaic!")
                    .font(.title.bold())
                    .foregroundColor(Theme.accent)
                            .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.vertical, 20)
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(){
                    Text("""
                    Here’s how to use the app:
                    
                    **Tracking Your Mood**
                    • Tap emojis that best match your feelings today.
                    • You can select more than one!
                    • Use the note field to write more about your mood.
                    
                    **Daily Notes**
                    • Your note is saved when you tap “Submit.”
                    • Each day is saved separately, so you can look back later!
                    
                    **Dark & Light Mode**
                    • Switch between light and dark mode in Settings.
                    
                    **MoodyKares Chatbot**
                    • Not sure how you feel? Try our friendly AI for a boost.
                    
                    **Notifications**
                    • You’ll soon be able to set daily reminders to track your mood!
                    
                    Have more questions or ideas? We’d love to hear from you in future updates.
                    """)
                }
                .padding(.bottom, 20)
                
                Button("Return"){
                    switchManager.setView(.settings)
                }
                .buttonStyle(BlueButton())
            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    HelpView()
}
