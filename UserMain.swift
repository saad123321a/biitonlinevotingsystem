//
//  UserMain.swift
//  Biit_Voting_App
//
//  Created by Macboook on 18/04/2024.
//

import SwiftUI

struct UserMain: View {
    @State private var showAlert = false
    @State private var selectedDestination: Destination?
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToWelcome = false

    enum Destination {
        case currentVoting, currentSocietyVoting, currentsurvey
    }

    var body: some View {
        NavigationView {
            VStack {
                
                
                
                VStack(spacing: 20) {
                    logoAndTitle
                    administratorLabel
                    
                    VStack(alignment: .leading, spacing: 20) {
                        navigationLink(for: .currentVoting, label: "Current Voting")
                        navigationLink(for: .currentSocietyVoting, label: "Current Society Voting")
                        navigationLink(for: .currentsurvey, label: "Current Survey")
                        
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 7)
                }
                .padding()
            }.navigationBarItems(leading:
                                    NavigationLink(destination: Filteration()) {
                                       powerButton
                
                                            })
            .navigationBarTitle("User", displayMode: .inline)
        }
        .alert(isPresented: $showAlert, content: getLogoutAlert)
        .fullScreenCover(isPresented: $navigateToWelcome, content: {
            Welcome() // Navigate to Welcome screen
        })

    }
    private var powerButton: some View {
        Button(action: { showAlert.toggle() }) {
            Image(systemName: "power")
                .padding()
                .foregroundColor(.red)
        }
    }
    private var logoAndTitle: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("BIIT Voting System")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
        }
    }
    private var administratorLabel: some View {
        HStack {
            Image("admin")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text("User")
                .fontWeight(.bold)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, 10)
    }
    private func navigationLink(for destination: Destination, label: String) -> some View {
        NavigationLink(destination: destinationView(for: destination), tag: destination, selection: $selectedDestination) {
            CustomButton(label: label)
        }
    }
    
    private func destinationView(for destination: Destination) -> some View {
        switch destination {
        case .currentVoting:
            return AnyView(UserCastVote())
        case .currentSocietyVoting:
            return AnyView(UserCastSocietyVote())
        case .currentsurvey:
            return AnyView(Result())
       
        
        }
    }
    private func getLogoutAlert() -> Alert {
        Alert(
            title: Text("Log out"),
            message: Text("Are you sure you want to log out?"),
            primaryButton: .destructive(Text("Log Out")) {
                //presentationMode.wrappedValue.dismiss()
                navigateToWelcome = true
            },
            secondaryButton: .cancel()
        )
    }
    struct CustomButton: View {
        var label: String
        
        var body: some View {
            Text(label)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.pink)
                .cornerRadius(8)
        }
    }
}

struct UserMain_Previews: PreviewProvider {
    static var previews: some View {
        UserMain()
    }
}
