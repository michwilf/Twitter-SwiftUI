//
//  NewMessageView.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 02/06/2022.
//

import SwiftUI

struct NewMessageView: View {
    @State var searchText = ""
    @Binding var show: Bool
    @Binding var startChat: Bool
    @Binding var isEditing: Bool
    @ObservedObject var viewModel = SearchViewModel(config: .search)
    
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                    HStack { Spacer() }
                    Button(action: {
                        self.show.toggle()
                        self.startChat.toggle()
                    }, label: {
                        UserCell(user: user)
                    })
                }
            }
            .padding(.leading)
        }
        
    }
}

//struct NewMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewMessageView(show: .constant(true), startChat: .constant(true), isEditing: .constant(false))
//    }
//}
