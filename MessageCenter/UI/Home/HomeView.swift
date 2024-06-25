//
//  HomeView.swift
//  MessageCenter
//
//  Created by Jay Muthialu on 6/18/24.
//

import SwiftUI

struct HomeView: View {

    @FocusState var emailTextFieldFocusState: Bool
    @State var showEmailAlert = false
    @Binding var showHomeView: Bool
    @Binding var emailIdString: String
    
    var body: some View {
        
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
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showHomeView = false
                    }
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
        .onTapGesture {
            emailTextFieldFocusState = false
        }
    }
}

#Preview {
    @State var showHomeView = true
    @State var emailIdString = "mtaylor@gmail.com"
    
    return HomeView(showHomeView: $showHomeView, emailIdString: $emailIdString)
}
