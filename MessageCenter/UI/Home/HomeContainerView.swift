//
//  HomeContainerView.swift
//  MessageCenter
//
//  Created by Jay Muthialu on 6/19/24.
//

import SwiftUI

struct HomeContainerView: View {
    
    @AppStorage("userEmailId") var emailIdString: String = ""
    @State var showHomeView = true
    
    var body: some View {
        if showHomeView {
            HomeView(showHomeView: $showHomeView, emailIdString: $emailIdString)
                .modifier(ScaleModifier(showView: showHomeView))
        } else {
            MessagesContainerView(showHomeView: $showHomeView, emailString: emailIdString)
                .modifier(ScaleModifier(showView: !showHomeView))
        }
    }
}

#Preview {
    HomeContainerView()
}
