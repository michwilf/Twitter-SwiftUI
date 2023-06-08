//
//  ProfileActionButtonView.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 03/06/2022.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
  
    var body: some View {
        if viewModel.user.isCurrentUser {
            Button(action: {
            },
                   label: {
                Text("Edit Profile")
                    .frame(width: 360, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
            })
            .cornerRadius(20)
        } else {
            HStack {
                Button(action: {
                    viewModel.user.isFollowed ? viewModel.unfollow() : viewModel.follow()
                },
                       label: {
                    Text(viewModel.user.isFollowed ? "Following" : "Follow")
                        .frame(width: 180, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                    
                })
                .cornerRadius(20)
                .shadow(color: .black, radius: 3, x: 0.0, y: 0.0)
                
                NavigationLink(destination: ChatView(user: viewModel.user), label: {
                        Text("Message")
                            .frame(width: 180, height: 40)
                            .background(Color.purple)
                            .foregroundColor(.white)
                })
                .cornerRadius(20)
                .shadow(color: .black, radius: 3, x: 0.0, y: 0.0)
            }
        }
        
    }
}


