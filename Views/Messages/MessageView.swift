//
//  MessageView.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 02/06/2022.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading, 100)
                    .padding(.trailing, 16)
            } else {
                HStack(alignment: .bottom) {
                    KFImage(URL(string: message.user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(message.text)
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .foregroundColor(.black)
                    
                }
                .padding(.horizontal)
                .padding(.trailing, 16)
                .padding(.leading, 100)
                Spacer()
            }
        }
    }
}
