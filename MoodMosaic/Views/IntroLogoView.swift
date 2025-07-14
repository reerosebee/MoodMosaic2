//
//  IntroLogoView.swift
//  MoodMosaic
//
//  Created by Riya  on 5/3/25.
//

import SwiftUI

struct IntroLogoView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared

    var body: some View {
        ZStack{
            Theme.background
                .ignoresSafeArea()
            VStack{
                Text("Welcome to")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                            .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.horizontal)
                Image("MoodMosaicFull")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 520, height: 340)
                    .padding(.bottom, 20)
                Button("Click To Continue"){
                    switchManager.setView(.selectProfile)
                }
                .buttonStyle(BlueButton())
            }
        }
    }
}

#Preview {
    IntroLogoView()
}
