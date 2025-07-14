//
//  SwitchViewsManager.swift
//  MoodMosaic
//
//  Created by Riya  on 2/20/25.
//

import Foundation

enum ActiveView {
    case selectProfile
    case moodTracker
    case activitiesList
    case startList
    case settings
    case data
    case aibot
    case introai
    case quote
    case community
    case intrologo
    case help
    case termsAndConditions
}

class SwitchViewsManager: ObservableObject {
    static let shared = SwitchViewsManager()
    
    @Published var activeView: ActiveView = .intrologo // Default to profile selection
    
    func setView(_ view: ActiveView) {
        activeView = view
    }
}
