//
//  ActivitiesListView.swift
//  MoodMosaic
//
//  Created by Riya  on 2/20/25.
//

import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
}

struct ActivitiesListView: View {
    private var pink = Color(red: 235/255, green: 17/255, blue: 216/255)
    
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @State private var selectedActivity: Activity? // Stores selected activity for the popup

    let happyActivities = [
        Activity(name: "Dancing", imageName: "dance", description: "Move to the rhythm and lift your spirits!"),
        Activity(name: "Singing", imageName: "sing", description: "Express yourself through music."),
        Activity(name: "Drawing", imageName: "draw", description: "Let your creativity flow with colors.")
    ]
    
    let sadActivities = [
        Activity(name: "Journaling", imageName: "journal", description: "Write down your thoughts to clear your mind."),
        Activity(name: "Meditation", imageName: "meditate", description: "Find peace with mindful breathing."),
        Activity(name: "Listening to Music", imageName: "music", description: "Let music soothe your soul.")
    ]
    
    let anxiousActivities = [
        Activity(name: "Breathing", imageName: "breathe", description: "Take slow, deep breathes to calm down."),
        Activity(name: "Origami", imageName: "origami", description: "Fold some origami to calm your nerves."),
        Activity(name: "Yoga", imageName: "yoga", description: "Stretch and release tension."),
        Activity(name: "Reading", imageName: "read", description: "Escape into another world.")
    ]
    
    let annoyedActivities = [
        Activity(name: "Exercise", imageName: "exercise", description: "Burn off frustration with movement."),
        Activity(name: "Talking to a Friend", imageName: "talk", description: "Vent and find support."),
        Activity(name: "Gaming", imageName: "game", description: "Distract yourself with a fun challenge.")
    ]

    
    var body: some View {
        ZStack{
            Theme.background
                .ignoresSafeArea()
            VStack{
                Text("Activites")
                    .font(.largeTitle.bold())
                    .foregroundColor(Theme.accent)
                            .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("How do you feel today?")
                    .font(.title3.bold())
                    .foregroundColor(pink)
                            .shadow(color: .pink.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(){
                    activitySection(title: "Happy", color: Theme.primary, activities: happyActivities)
                    activitySection(title: "Sad", color: Theme.primary, activities: sadActivities)
                    activitySection(title: "Anxious", color: Theme.primary, activities: anxiousActivities)
                    activitySection(title: "Annoyed", color: Theme.primary, activities: annoyedActivities)
                    
                }
                
                Button ("Back to Home") {
                    switchManager.setView(.startList)
                }
                .buttonStyle(BlueButton())
                
            }
            .padding()
            .sheet(item: $selectedActivity) { activity in
                ActivityDetailView(activity: activity)
            }

        }
        
    }
    
    private func activitySection(title: String, color: Color, activities: [Activity]) -> some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.primary)
                    .shadow(color: .blue.opacity(0.3), radius: 2, x: 0, y: 2)
                Divider()
                    .background(Theme.divider)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(activities) { activity in
                            VStack {
                                Image(activity.imageName)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .onTapGesture {
                                        selectedActivity = activity
                                    }
                                
                                Text(activity.name)
                                    .foregroundColor(Theme.primary)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
    }
}

struct ActivityDetailView: View {
    let activity: Activity
    
    var body: some View{
        ZStack{
            Theme.background.ignoresSafeArea()
            VStack {
                Image(activity.imageName)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                
                Text(activity.name)
                    .font(.title)
                    .bold()
                
                Text(activity.description)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ActivitiesListView()
}
