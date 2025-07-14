//
//  TermsAndConditionsView.swift
//  MoodMosaic
//
//  Created by Riya  on 5/4/25.
//

import SwiftUI

struct TermsAndConditionsView: View {
    @ObservedObject var switchManager = SwitchViewsManager.shared

    var body: some View {
        ZStack{
            Theme.background.ignoresSafeArea()
            VStack{
                Text("Terms and Conditions")
                    .font(.largeTitle.bold())
                    .foregroundColor(Theme.accent)
                    .padding(.bottom, 10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Group {
                            Text("1. Introduction")
                                .font(.title2.bold())
                            Text("Welcome to MoodMosaic! By using our app, you agree to these terms and conditions. Please read them carefully.")
                            
                            Text("2. User Accounts")
                                .font(.title2.bold())
                            Text("Users may create personal profiles to track their moods and notes. You agree not to impersonate others or provide false information.")
                            
                            Text("3. Data & Privacy")
                                .font(.title2.bold())
                            Text("MoodMosaic stores your emoji history and notes locally on your device. We do not collect, sell, or share your data.")
                        }
                        
                        Group {
                            Text("4. App Usage Rules")
                                .font(.title2.bold())
                            Text("You agree not to misuse the app, disrupt services, reverse engineer, or access data that does not belong to you.")
                            
                            Text("5. Content Ownership")
                                .font(.title2.bold())
                            Text("You retain ownership of the notes and emoji logs you create. MoodMosaic retains ownership of the app design, code, and features.")
                            
                            Text("6. Limitation of Liability")
                                .font(.title2.bold())
                            Text("MoodMosaic is a self-care tool and not a substitute for medical or psychological advice. We are not responsible for any harm, loss, or data issues resulting from use of the app.")
                        }
                        
                        Group {
                            Text("7. Termination")
                                .font(.title2.bold())
                            Text("We may suspend or restrict access to the app if you violate these terms.")
                            
                            Text("8. Changes to Terms")
                                .font(.title2.bold())
                            Text("We may update these terms over time. Continued use of the app means you accept the updated terms.")
                        }
                    }
                    .padding()
                    .padding(.horizontal, 15)
                }
                Button("Accept and Return") {
                    switchManager.setView(.quote)
                }
                .buttonStyle(BlueButton())
                .padding(.top, 30)
            }
        }
    }
}

#Preview {
    TermsAndConditionsView()
}
