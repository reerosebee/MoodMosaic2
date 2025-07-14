//
//  ProfileManager.swift
//  MoodMosaic
//
//  Created by Riya  on 2/18/25.
//

import Foundation
import UIKit

class ProfileManager: ObservableObject {
    static let shared = ProfileManager()
    
    @Published var profiles: [UserProfile] = []
    @Published var activeUser: UserProfile?
    
    private let profilesKey = "savedProfiles"
    private let activeUserKey = "activeUser"
    
    private init() {
        loadProfiles()
        loadActiveUser()
        
     //   NotificationCenter.default.addObserver(self, selector: #selector(resetActiveUser), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    
    
    // Reset active user when the app is closing
    @objc private func resetActiveUser() {
        activeUser = nil
        UserDefaults.standard.removeObject(forKey: activeUserKey) // Remove from storage
    }
    
    func addEmojis(for date: Date, emojis: [String]) {
        guard var user = activeUser, !emojis.isEmpty else { return }

        let normalizedDate = Calendar.current.startOfDay(for: date)

        // Update emoji history
        var history = user.emojiHistory
        if history[normalizedDate] != nil {
            history[normalizedDate]?.append(contentsOf: emojis)
        } else {
            history[normalizedDate] = emojis
        }
        user.emojiHistory = history

        // Replace in profiles array
        if let index = profiles.firstIndex(where: { $0.id == user.id }) {
            profiles[index] = user
        }

        activeUser = user
        objectWillChange.send()
        saveProfiles()
        saveActiveUser()
    }

    
    // Add a new profile
    func addProfile(name: String, avatar: String) {
        let newProfile = UserProfile(id: UUID(), name: name, avatar: avatar, emojiHistory: [:])
        profiles.append(newProfile)
        saveProfiles()
    }
    
    // Delete a profile
    func deleteProfile(_ profile: UserProfile) {
        profiles.removeAll { $0.id == profile.id}
        saveProfiles()
    }
    
    // Set the active user
    func setActiveUser(_ profile: UserProfile) {
        activeUser = profile
        saveActiveUser()
    }
    
    // Save profiles to UserDefaults
    private func saveProfiles() {
        if let encoded = try? JSONEncoder().encode(profiles) {
            UserDefaults.standard.set(encoded, forKey: profilesKey)
        }
    }
    
    // Load profiles from UserDefaults
    private func loadProfiles() {
        if let savedData = UserDefaults.standard.data(forKey: profilesKey),
           let decodedProfiles = try? JSONDecoder().decode([UserProfile].self, from: savedData) {
            profiles = decodedProfiles
        }
    }
    
    // Save active user
    private func saveActiveUser() {
        if let activeUser = activeUser,
           let encoded = try? JSONEncoder().encode(activeUser) {
            UserDefaults.standard.set(encoded, forKey: activeUserKey)
        }
    }
    
    // Load active user
    private func loadActiveUser() {
        if let savedData = UserDefaults.standard.data(forKey: activeUserKey),
           let decodedUser = try? JSONDecoder().decode(UserProfile.self, from: savedData) {
            activeUser = decodedUser
        }
    }
    
    func addNote(for date: Date, note: String) {
        guard var user = activeUser else { return }

        let normalizedDate = Calendar.current.startOfDay(for: date)
        var currentNotes = user.notes
        currentNotes[normalizedDate] = note
        user.notes = currentNotes

        if let index = profiles.firstIndex(where: { $0.id == user.id }) {
            profiles[index] = user
        }

        activeUser = user
        objectWillChange.send()
        saveProfiles()
        saveActiveUser()
    }
}

struct UserProfile: Identifiable, Codable {
    let id: UUID
    var name: String
    var avatar: String
    
    private var storedEmojiHistory: [String: [String]] = [:]
    private var storedNotes: [String: String] = [:]

    var emojiHistory: [Date: [String]] {
        get {
            var result: [Date: [String]] = [:]
            let formatter = ISO8601DateFormatter()
            for (key, value) in storedEmojiHistory {
                if let date = formatter.date(from: key) {
                    result[date] = value
                }
            }
            return result
        }
        set {
            let formatter = ISO8601DateFormatter()
            storedEmojiHistory = Dictionary(uniqueKeysWithValues: newValue.map { (date, emojis) in
                (formatter.string(from: date), emojis)
            })
        }
    }
    
    var notes: [Date: String] {
        get {
            var result: [Date: String] = [:]
            let formatter = ISO8601DateFormatter()
            for (key, value) in storedNotes {
                if let date = formatter.date(from: key) {
                    result[date] = value
                }
            }
            return result
        }
        set {
            let formatter = ISO8601DateFormatter()
            storedNotes = Dictionary(uniqueKeysWithValues: newValue.map { (date, note) in
                (formatter.string(from: date), note)
            })
        }
    }
    
    init(id: UUID = UUID(), name: String, avatar: String, emojiHistory: [Date: [String]] = [:], notes: [Date: String] = [:]) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.emojiHistory = emojiHistory
        self.notes = notes
    }
}
