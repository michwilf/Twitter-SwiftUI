//
//  NewTweetsView.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 04/06/2022.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @Binding var isPresented: Bool
    @State var captionText: String = ""
    @ObservedObject var viewModel: UploadTweetViewModel
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.viewModel = UploadTweetViewModel(isPresented: isPresented)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    if let user = AuthViewModel.shared.user {
                        KFImage(URL(string: user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 64, height: 64)
                        .cornerRadius(32)
                    }
                    
                    TextArea("Whats happening.?", text: $captionText)
                    
                    Spacer()
                }
                .padding()
                .navigationBarItems(leading: Button(action: {isPresented.toggle()
                }, label: {
                        Text("Cancel")
                        .foregroundColor(.blue)
                    }),
                        trailing: Button(action: {
                    viewModel.uploadTweet(caption: captionText)
                }, label: {
                    Text("Tweet")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
            }) )
                Spacer()
            }
        }
    }
}

struct NewTweetsView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView(isPresented: .constant(true))
    }
}
