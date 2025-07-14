//
//  SelectProfileView.swift
//  MoodMosaic
//
//  Created by Riya  on 2/18/25.
//

import SwiftUI

struct SelectProfileView: View {
    @ObservedObject var profileManager = ProfileManager.shared
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @State private var showCreateProfile = false
    
    var body: some View {
        ZStack{
            Theme.background
                .ignoresSafeArea()
            VStack (alignment: .center, spacing: 0) {
                Image("MoodMosaicLogo")
                    .resizable()
                    .frame(width: 150, height: 150)
                Text("Who's using the app?")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.accent)
                            .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 50)
                    .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(profileManager.profiles) { profile in
                            Button(action: {
                                profileManager.setActiveUser(profile)
                                switchManager.setView(.quote)
                            }) {
                                VStack {
                                    Image(profile.avatar)
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .background(.white)
                                        .clipShape(Circle())
                                        .padding(.bottom)
                                        
                                    Text(profile.name)
                                        .padding()
                                        .font(.headline)
                                        .foregroundStyle(Theme.accent)
                                        .background(.white)
                                        .clipShape(Capsule())
                                }
                            }
                            .padding()
                        }
                        
                        // Button to add a new profile
                        Button(action: { showCreateProfile = true }) {
                            VStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(Theme.primary)
                                
                                Text("Add Profile")
                                    .foregroundStyle(Theme.primary)
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 40)
            .padding(.top, 30)
            .sheet(isPresented: $showCreateProfile) {
                CreateProfileView()
                Spacer()
            }
            
            
        }
        
    }
}

#Preview {
    SelectProfileView()
}
