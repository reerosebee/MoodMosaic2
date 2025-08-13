//
//  DataView.swift
//  MoodMosaic
//
//  Created by Riya  on 2/23/25.
//

import SwiftUI
import Charts

private var pink = Color(red: 235/255, green: 17/255, blue: 216/255)

struct DataView: View {
    
    @ObservedObject var profileManager = ProfileManager.shared
    @ObservedObject var switchManager = SwitchViewsManager.shared
    
    var body: some View {
        
        ZStack{
            Theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("History")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.accent)
                            .shadow(color: Theme.accent.opacity(0.3), radius: 2, x: 0, y: 2)
                    .padding(.top, 20)
                    .padding(.horizontal)
                ScrollView{
                    EmojiCalendarView()
                    EmotionChartView()
                }
                Button("Back Home"){
                    switchManager.setView(.startList)
                }
                .buttonStyle(BlueButton())
            }
            
        }
    }
    
}

struct EmojiCalendarView: View {
    @ObservedObject var profileManager = ProfileManager.shared
    @State private var currentMonth: Date = Date()
    @State private var selectedDate: IdentifiableDate? = nil
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack(spacing: 8) {
            // Header with month and arrows
            HStack {
                Button(action: {
                    changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(monthYearString(from: currentMonth))
                    .font(.headline)
                    .foregroundColor(Theme.primary)
                
                Spacer()
                
                Button(action: {
                    changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // Day labels (Sun to Sat)
            HStack {
                ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
            }

            // Calendar grid
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(daysInMonth(), id: \.self) { date in
                    let day = Calendar.current.component(.day, from: date)
                    if date != Date.distantPast {
                        Button(action: {
                            selectedDate = IdentifiableDate(date: date)
                        }) {
                            VStack(spacing: 2) {
                                Text("\(day)")
                                    .font(.caption)
                                    .foregroundColor(isSameMonth(date) ? .primary : .gray)
                                Text(getEmojis(for: date))
                                    .font(.caption2)
                            }
                            .frame(width: 40, height: 50)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(6)
                            .shadow(radius: 1)
                        }
                    } else {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 40, height: 50)
                    }
                }
            }
        }
        .padding()
        .sheet(item: $selectedDate) { identifiable in
            DayDetailsView(date: identifiable.date)
        }

    }

    func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newDate
        }
    }

    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    func daysInMonth() -> [Date] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth),
              let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))
        else { return [] }

        var days: [Date] = []
        
        // Add leading blank days for alignment
        let weekday = calendar.component(.weekday, from: startOfMonth)
        let padding = weekday - calendar.firstWeekday
        for _ in 0..<padding {
            days.append(Date.distantPast) // Placeholder date
        }

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(date)
            }
        }
        
        return days
    }

    func isSameMonth(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
    }

    func getEmojis(for date: Date) -> String {
        if date == Date.distantPast { return "" } // empty placeholder
        let normalizedDate = Calendar.current.startOfDay(for: date)
        return profileManager.activeUser?.emojiHistory[normalizedDate]?.joined(separator: " ") ?? " "
    }
}

struct DayDetailsView: View {
    @ObservedObject var profileManager = ProfileManager.shared
    let date: Date

    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()
            VStack {
                Text(formattedDate(date))
                    .font(.title2.bold())
                    .padding(.bottom, 10)
                
                if let emojis = profileManager.activeUser?.emojiHistory[Calendar.current.startOfDay(for: date)], !emojis.isEmpty {
                    Text("Emojis:")
                        .font(.headline)
                    Text(emojis.joined(separator: " "))
                        .font(.largeTitle)
                        .padding(.bottom, 10)
                } else {
                    Text("No emojis for this day.")
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }
                
                if let note = profileManager.activeUser?.notes[Calendar.current.startOfDay(for: date)], !note.isEmpty {
                    Text("Note:")
                        .font(.headline)
                    ScrollView {
                        Text(note)
                            .padding()
                    }
                } else {
                    Text("No note for this day.")
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct EmotionChartView: View {
    @ObservedObject var profileManager = ProfileManager.shared
    
    var weeklyData: [EmotionCount] {
        guard let emojiHistory = profileManager.activeUser?.emojiHistory else { return [] }

        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        
        return emojiHistory
            .filter { $0.key >= lastWeek } // Get last 7 days' data
            .flatMap { $0.value }
            .reduce(into: [:]) { counts, emoji in counts[emoji, default: 0] += 1 }
            .map { EmotionCount(emoji: $0.key, count: $0.value) }
    }

    var body: some View {
        VStack {
           Text("Weekly Emotion Summary")
               .font(.headline)
               .padding(.bottom, 5)
           if !weeklyData.isEmpty {
               Chart(weeklyData) { data in
                   BarMark(
                       x: .value("Count", data.count),
                       y: .value("Emotion", data.emoji)
                   )
                   .foregroundStyle(by: .value("Emoji", data.emoji))
               }
               .chartXAxis(.hidden)
               .chartYAxis {
                   AxisMarks(position: .leading)
               }
               .frame(height: 200)
               .padding()
           } else {
               Text("No emotion data for the last week.")
                   .foregroundColor(.gray)
                   .padding()
           }
        }
    }
}

struct EmotionCount: Identifiable {
    let id = UUID()
    let emoji: String
    let count: Int
}

struct IdentifiableDate: Identifiable {
    let id = UUID()
    let date: Date
}

#Preview {
    DataView()
}
