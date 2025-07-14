//
//  EmojiInfoView.swift
//  MoodMosaic
//
//  Created by Riya  on 2/20/25.
//

import SwiftUI

struct EmojiInfoView: View {
    let emojiEmotions = [
        "😄": "Happy",
        "🥲": "Bittersweet",
        "😊": "Content",
        "🥰": "Loved",
        "😌": "Relieved",
        "🤪": "Goofy",
        "🧐": "Curious",
        "😎": "Chill",
        "🥳": "Celebrating",
        "😒": "Annoyed",
        "😞": "Sad",
        "😔": "Disappointed",
        "☹️": "Upset",
        "😖": "Distressed",
        "😭": "Crying",
        "😤": "Frustrated",
        "🤬": "Angry",
        "😰": "Anxious",
        "🤗": "Affectionate",
        "🫣": "Shy",
        "🫠": "Exasperated",
        "🤥": "Liar",
        "🫥": "Invisible",
        "🫨": "Shook",
        "😬": "Nervous",
        "🙄": "Bored",
        "🥱": "Tired",
        "😵‍💫": "Dizzy",
        "🤢": "Nauseous",
        "🤒": "Sick"
    ]
    
    var body: some View {
        Text("List of Emojis and Their Emotions")
            .font(.headline)
            .padding()
        ScrollView {
            VStack (alignment: .leading) {
                ForEach(emojiEmotions.sorted(by: <), id: \.key) { item in
                    HStack{
                        Text(item.key)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(item.value)
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EmojiInfoView()
}
