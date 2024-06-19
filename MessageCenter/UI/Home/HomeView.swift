//
//  HomeView.swift
//  MessageCenter
//
//  Created by Jay Muthialu on 6/18/24.
//

import SwiftUI

struct HomeView: View {

    @FocusState var emailTextFieldFocusState: Bool
    
    @AppStorage("userEmailId") var emailIdString: String = ""
    @State var showEmailAlert = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                    .frame(height: 50)
                
                Image("roomsToGo")
                    .padding()
                
                Text("messageCenter")
                    .font(FontPalette.largeRegular.font)
                    .padding(.bottom, 30)
                
                Text("enterYourEmailToSearch")
                    .font(FontPalette.mediumRegular.font)
                    .padding(.bottom, 20)
                
                UnderLinedTextField(emailIdString: $emailIdString)
                    .focused($emailTextFieldFocusState)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 35)
                
                ThemedButton(buttonText: "GetMessages") {
                    let trimmedEmailString = emailIdString.trimmingCharacters(in: .whitespacesAndNewlines)
                    emailIdString = trimmedEmailString
                    if emailIdString.isValidEmailId() {
                        path.append(emailIdString)
                    } else {
                        showEmailAlert = true
                    }
                }
                .alert(isPresented: $showEmailAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("PleaseEnterValidEmail")
                    )
                }
                
                Spacer()
            }
            .navigationDestination(for: String.self) { emailString in
                MessagesContainerView(emailString: emailString)
                    .toolbarRole(.editor)
            }
        }
        .onTapGesture {
            emailTextFieldFocusState = false
        }
    }
}

#Preview {
    HomeView()
}
