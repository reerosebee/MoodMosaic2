//
//  SettingsView.swift
//  MoodMosaic
//
//  Created by Riya  on 2/20/25.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @State private var forceUpdate = false
    @State private var notificationsEnabled = false
    
    var body: some View {
        ZStack{
            Theme.background
                 .ignoresSafeArea()
            VStack (spacing: 20){
                Text("Settings")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.accent)
                    .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 40)
                    .padding(.horizontal)
                Button(action: {
                    isDarkMode.toggle()
                    forceUpdate.toggle()
                }) {
                    Text("Switch to \(isDarkMode ? "Light" : "Dark") Mode")
                        .foregroundColor(Theme.text)
                }
                .buttonStyle(BlueButton())
                
               
                Button(action: {
                    notificationsEnabled.toggle()
                    if notificationsEnabled {
                        requestNotificationAuthorization()
                        scheduleDailyCheckInNotification()
                    } else {
                        cancelAllNotifications()
                    }
                }) {
                    Text(notificationsEnabled ? "Turn Off Daily Reminder" : "Turn On Daily Reminder")
                        .foregroundColor(Theme.text)
                }
                .buttonStyle(BlueButton())
                 
                Button("Help"){
                    switchManager.setView(.help)
                }
                .buttonStyle(BlueButton())
                
                Button("Back Home"){
                    switchManager.setView(.startList)
                }
                .buttonStyle(BlueButton())
            }
        }
        .id(forceUpdate)
        .onAppear {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                DispatchQueue.main.async {
                    notificationsEnabled = (settings.authorizationStatus == .authorized)
                }
            }
        }
    }
}

func requestNotificationAuthorization() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            print("Notifications authorized.")
        } else if let error = error {
            print("Error requesting notification authorization: \(error.localizedDescription)")
        } else {
            print("Notifications not authorized.")
        }
    }
}

func scheduleDailyCheckInNotification() {
    let center = UNUserNotificationCenter.current()

    let content = UNMutableNotificationContent()
    content.title = "Time to Check In!"
    content.body = "Document your healthy activities for today and nurture your mental well-being."
    content.sound = .default

    // Configure the trigger for a specific time (10:00 AM)
    var dateComponents = DateComponents()
    dateComponents.hour = 10
    dateComponents.minute = 0
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

    // Create the request
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // Schedule the request
    center.add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Daily check-in notification scheduled for 10:00 AM.")
        }
    }
}

func cancelAllNotifications() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    print("All pending notifications cancelled.")
}

#Preview {
    SettingsView()
}
