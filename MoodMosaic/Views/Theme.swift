//
//  Theme.swift
//  MoodMosaic
//
//  Created by Riya  on 4/29/25.
//

import SwiftUI

private var blue = Color(red: 63/255, green: 167/255, blue: 244/255)
private var lightBlue = Color(red: 227/255, green: 245/255, blue: 255/255)
private var purple = Color(red: 110/255, green: 125/255, blue: 235/255)
private var pink = Color(red: 235/255, green: 17/255, blue: 216/255)
private var black = Color(red: 15/255, green: 15/255, blue: 15/255)

struct Theme {
    static var isDarkMode: Bool {
        UserDefaults.standard.bool(forKey: "isDarkMode")
    }

    static var background: Color {
        isDarkMode ? black : lightBlue
    }

    static var primary: Color {
        isDarkMode ? Color(red: 180/255, green: 200/255, blue: 255/255) : blue
    }

    static var accent: Color {
        isDarkMode ? purple : purple
    }

    static var text: Color {
        isDarkMode ? .white : .white
    }
    
    static var shadow: Color {
        isDarkMode ? .purple : .gray
    }
    
    static var divider: Color{
        isDarkMode ? .white : .gray
    }
    
    static var chatbot: Color{
        isDarkMode ? Color(red: 115/255, green: 117/255, blue: 117/255) : Color(red: 202/255, green: 233/255, blue: 250/255)
    }
}
