//
//  Search.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 27/04/2022.
//

import SwiftUI
import Kingfisher

struct Search: View {
    
    @State var searchText = ""
    @ObservedObject var viewModel = SearchViewModel(config: .newMessage)
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                    HStack { Spacer() }
                    
                    NavigationLink(
                        destination: LazyView(UserProfileView(user: user)),
                        label: {
                            UserCell(user: user)
                        })
                   
                }
            }
            .padding(.leading)
        }
        
    }
    
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
