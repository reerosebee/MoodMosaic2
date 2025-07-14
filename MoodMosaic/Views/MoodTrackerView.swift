//
//  MoodTrackerView.swift
//  MoodMosaic
//
//  Created by Riya  on 2/18/25.
//

import SwiftUI

struct MoodTrackerView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @ObservedObject var profileManager = ProfileManager.shared
    
    @State private var selectedEmojis: [String] = []
    let emojis = ["😄", "🥲", "😊", "🥰", "😌", "🤪", "🧐", "😎", "🥳", "😒", "😞", "😔", "☹️", "😖", "😭", "😤", "🤬", "😰", "🤗", "🫣", "🫠", "🤥", "🫥", "🫨", "😬", "🙄", "🥱", "😵‍💫", "🤢", "🤒"]
    
    @State private var showEmojiInfo = false
    @State private var note: String = ""
    
    var body: some View {
        ZStack{
            Theme.background
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("How are you feeling today?")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(Theme.accent)
                                .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                        .padding(.bottom, 20)
                        .padding(.horizontal)
                        .overlay(
                            Button ("  ?") {
                                showEmojiInfo = true
                                
                            }.padding(.trailing, 10)
                                .background(Theme.primary)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                                .padding(.top, 10),
                            alignment: .topTrailing)
                }
                .padding()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.largeTitle)
                        
                            .background(selectedEmojis.contains(emoji) ? Color.blue.opacity(0.3) : Color.clear)
                            .cornerRadius(10)
                            .onTapGesture {
                                toggleEmojiSelection(emoji)
                            }
                    }
                }
                .padding()
                
                TextField("Write a note about how you're feeling today", text: $note)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .multilineTextAlignment(.leading)
                   .padding(.horizontal, 30)
                   .padding(.vertical, 20)
                   
                               
                Button ("Unsure? Try Our ChatBot MoodyKares! "){
                    switchManager.setView(.introai)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
                
                Button ("Submit") {
                    let today = Date()
                    profileManager.addEmojis(for: today, emojis: selectedEmojis)
                    profileManager.addNote(for: today, note: note)
                    switchManager.setView(.startList)
                }
                .buttonStyle(BlueButton())
                
               
                
            }
            .sheet(isPresented: $showEmojiInfo) {
                EmojiInfoView()
            }
            .onAppear {
                DispatchQueue.main.async {
                    let today = Calendar.current.startOfDay(for: Date())
                    note = profileManager.activeUser?.notes[today] ?? ""
                }
            }
            
            
        }
    }
    
    private func toggleEmojiSelection(_ emoji: String) {
        if selectedEmojis.contains(emoji) {
            selectedEmojis.removeAll { $0 == emoji }
        } else {
            selectedEmojis.append(emoji)
        }
    }
}

#Preview {
    MoodTrackerView()
}
