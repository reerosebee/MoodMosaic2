//
//  MoodMosaicApp.swift
//  MoodMosaic
//
//  Created by Riya  on 12/1/24.
//

import SwiftUI

@main
struct MoodMosaicApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .id(isDarkMode)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
