//
//  CommunityView.swift
//  MoodMosaic
//
//  Created by Riya  on 5/1/25.
//
import SwiftUI

struct CommunityMember: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let rating: Int
}

struct CommunityView: View {
    @State private var searchText = ""
    @ObservedObject var switchManager = SwitchViewsManager.shared
    
    let members: [CommunityMember] = [
        CommunityMember(imageName: "person.2.fill", title: "Therapist Jane", rating: 4),
        CommunityMember(imageName: "person.3.fill", title: "Peer Chat Group", rating: 3),
        CommunityMember(imageName: "person.crop.circle", title: "Youth Mentor", rating: 5)
    ]
    
    var body: some View {
            NavigationView {
                ZStack{
                Theme.background
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Community Support")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(Theme.accent)
                        .shadow(color: Theme.shadow.opacity(0.3), radius: 2, x: 0, y: 2)
                        .padding(.vertical, 20)
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(filteredMembers) { member in
                                HStack(alignment: .center) {
                                    Image(systemName: member.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                        .padding()
                                        .background(Theme.primary.opacity(0.1))
                                        .cornerRadius(10)
                                    
                                    VStack(alignment: .leading) {
                                        Rectangle()
                                            .fill(Theme.accent)
                                            .frame(height: 10)
                                            .cornerRadius(5)
                                        
                                        
                                        HStack(spacing: 4) {
                                            ForEach(0..<5) { i in
                                                Image(systemName: i < member.rating ? "star.fill" : "star")
                                                    .foregroundColor(Theme.primary)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.top)
                    HStack{
                        Button("Back to Home"){
                            switchManager.setView(.startList)
                        }
                        .buttonStyle(BlueButton())
                        .padding(.horizontal, 55)
                    }
                }
            }
        }
    }
    
    var filteredMembers: [CommunityMember] {
        if searchText.isEmpty {
            return members
        } else {
            return members.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    CommunityView()
}
