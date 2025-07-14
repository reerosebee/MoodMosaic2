//
//  CreateProfileView.swift
//  MoodMosaic
//
//  Created by Riya  on 2/18/25.
//

import SwiftUI

struct CreateProfileView: View {
    @ObservedObject var profileManager = ProfileManager.shared
    
    @State private var name = ""
    @State private var avatar = "Sloth" // Default avatar
    let avatarOptions = ["Sloth", "Deer", "Beaver", "Koala", "Panda", "Raccoon"]
    let maxProfiles = 3
    
    var body: some View {
        ZStack{
            Theme.background.ignoresSafeArea()
            VStack{
                VStack {
                    Text("Create a New Profile")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(Theme.accent)
                        .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                        .padding(.bottom, 20)
                        .padding(.horizontal)
                    
                    TextField("Enter Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // Dropdown for avatar selection
                    Section("Select an Avatar"){
                        Picker("Select an Avatar", selection: $avatar) {
                            ForEach(avatarOptions, id: \.self) { avatarOption in
                                Text(avatarOption).tag(avatarOption)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Use MenuPickerStyle for dropdown appearance
                        .padding(.top)
                        
                        // Display the selected avatar image
                        Image(avatar)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .padding(.bottom)
                        
                    }
                    Button("Create Profile") {
                        if !name.isEmpty, profileManager.profiles.count < maxProfiles {
                            profileManager.addProfile(name: name, avatar: avatar)
                            name = ""
                        }
                    }
                    .padding()
                    .background(profileManager.profiles.count >= maxProfiles ? Color.gray : Color.blue)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(profileManager.profiles.count >= maxProfiles)
                }
                
                Divider().padding()
                
                // Display profiles with delete functionality
                if profileManager.profiles.isEmpty {
                    Text("No profiles created yet.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(profileManager.profiles) { profile in
                            HStack {
                                Image(profile.avatar)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                
                                Text(profile.name)
                                    .font(.body)
                                
                                Spacer()
                                
                                Button(action: {
                                    profileManager.deleteProfile(profile)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .frame(height: 200) // Limit List height
                }
            }
        }
    }
}


#Preview {
    CreateProfileView()
}
