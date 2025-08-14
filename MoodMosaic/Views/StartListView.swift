//
//  StartListView.swift
//  MoodMosaic
//
//  Created by Riya  on 2/20/25.
//

import SwiftUI

struct StartListView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack{
            Theme.background
                .ignoresSafeArea()
            VStack(spacing: 15){
                Text("Where would you like to get started?")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.accent)
                            .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 40)
                    .padding(.horizontal)
                
                Button ("MoodyKares AI") {
                    switchManager.setView(.introai)
                }
                .buttonStyle(PinkGradientButton())
                
                
                Button ("Activities") {
                    switchManager.setView(.activitiesList)
                }
                .buttonStyle(BlueButton())
                
                Button ("Visualization") {
                    switchManager.setView(.data)
                }
                .buttonStyle(BlueButton())
                
                //to be implemented in the future
//                Button ("Community Support") {
//                    switchManager.setView(.community)
//                }
//                .buttonStyle(BlueButton())
                
                Button ("Settings") {
                    switchManager.setView(.settings)
                }
                .buttonStyle(BlueButton())
                
                Button ("Return to Profiles") {
                    switchManager.setView(.selectProfile)
                }
                .buttonStyle(BlueButton())
                .padding(.horizontal)
                
            }
        }
    }
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 250, minHeight: 50)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [ Theme.primary, Theme.accent]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .opacity(configuration.isPressed ? 0.85 : 1)
            )
            .foregroundColor(Theme.text)
            .font(.headline)
            .cornerRadius(14)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .shadow(color: Theme.shadow.opacity(0.1), radius: 5, x: 0, y: 3)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct PinkGradientButton: ButtonStyle {
    private var pink = Color(red: 235/255, green: 17/255, blue: 216/255)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 250, minHeight: 50)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink, pink]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .opacity(configuration.isPressed ? 0.85 : 1)
            )
            .foregroundColor(Theme.text)
            .font(.headline)
            .cornerRadius(14)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .shadow(color: Color.pink.opacity(0.3), radius: 5, x: 0, y: 3) // Consider a pink shadow
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    StartListView()
}
