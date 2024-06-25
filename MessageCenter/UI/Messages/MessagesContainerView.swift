//
//  MessagesContainerView.swift
//  MessageCenter
//
//  Created by Jay Muthialu on 6/19/24.
//

import SwiftUI

struct MessagesContainerView: View {
    
    @StateObject var viewModel = MessagesViewModel(
        messagesAPI: MessagesAPI(forType: .http)
    )
    @Binding var showHomeView: Bool
    let emailString: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: 0.50)) {
                        showHomeView = true
                    }
                }  label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .tint(Color.gray)
                }
                .padding(.trailing, 25)
            }
            .padding(.top, 30)
            
            Spacer()
                .frame(height: 20)
            
            MessageCenterHeader()

            Spacer()
            
            if viewModel.errorMessage.isEmpty {
                MessagesView(messages: viewModel.messages)
            } else {
                TryAgainView(errorMessage: viewModel.errorMessage) {
                    Task {
                        await viewModel.getMessages(forEmailID: emailString)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Spacer()
        }
        .task {
            await viewModel.getMessages(forEmailID: emailString)
        }
        .refreshable {
            await viewModel.getMessages(forEmailID: emailString)
        }
        .overlay {
            if viewModel.showProgressView {
                ProgressView()
            }
        }
    }
}

#Preview {
    let viewModel = MessagesViewModel(messagesAPI: MessagesAPI(forType: .mock))
    
    @State var showHomeView = false
    return MessagesContainerView(viewModel: viewModel,
                          showHomeView: $showHomeView,
                          emailString: "mtaylor@gmail.com")
}
