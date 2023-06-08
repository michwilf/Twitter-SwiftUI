//
//  SearchViewModel.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 07/06/2022.
//

import SwiftUI
import Firebase

enum SearchVideModelConfiguration {
    case search
    case newMessage
}

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    private let config: SearchVideModelConfiguration
    
    init(config: SearchVideModelConfiguration) {
        self.config = config
        fetchUsers(forConfig: config)
    }
    
    func fetchUsers(forConfig config: SearchVideModelConfiguration) {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let users = documents.map({ User(dictionary: $0.data()) })
            
            switch config {
            case .newMessage:
                self.users = users.filter({!$0.isCurrentUser})
            case .search:
                self.users = users
                
            }
           
            }
        }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter ({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.fullname.contains(lowercasedQuery) })
    }
    }
    
