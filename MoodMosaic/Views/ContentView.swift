//
//  ContentView.swift
//  MoodMosaic
//
//  Created by Riya  on 12/1/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var profileManager = ProfileManager.shared
    @ObservedObject var switchManager = SwitchViewsManager.shared
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        switch switchManager.activeView {
        case .intrologo:
            IntroLogoView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        case .selectProfile:
            SelectProfileView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        default:
            if profileManager.activeUser != nil {
                switch switchManager.activeView {
                case .intrologo:
                    IntroLogoView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .moodTracker:
                    MoodTrackerView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .selectProfile:
                    SelectProfileView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .startList:
                    StartListView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .activitiesList:
                    ActivitiesListView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .settings:
                    SettingsView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .data:
                    DataView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .aibot:
                    AIChatBotView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .introai:
                    IntroAIView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .quote:
                    QuoteView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .community:
                    CommunityView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .help:
                    HelpView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                case .termsAndConditions:
                    TermsAndConditionsView()
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                }
            } else {
                IntroLogoView()
            }
        }
    }
}

#Preview {
    ContentView()
}
