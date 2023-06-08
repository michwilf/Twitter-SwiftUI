//
//  Message.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 02/06/2022.
//

import Firebase

struct Message: Identifiable {
    let text: String
    let user: User
    let told: String
    let fromId: String
    let isFromCurrentUser: Bool
    let timestamp: Timestamp
    let id: String
    
    var chatPartnerId: String { return isFromCurrentUser ? told : fromId }
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        
        self.text = dictionary["text"] as? String ?? ""
        self.told = dictionary["told"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["uid"] as? String ?? ""
        
    }
}

struct MockMessage: Identifiable {
    let id: Int
    let imageName: String
    let messageText: String
    let isCurrentUser: Bool
}

let Mock_Messages: [MockMessage] = [
    .init(id: 0, imageName: "spiderman", messageText: "Hey what's up?", isCurrentUser: false),
    .init(id: 1, imageName: "batman", messageText: "Not much you?", isCurrentUser: true),
    .init(id: 2, imageName: "batman", messageText: "Hey what's up?", isCurrentUser: true),
    .init(id: 3, imageName: "spiderman", messageText: "Hey what's up?", isCurrentUser: false),
    .init(id: 4, imageName: "spiderman", messageText: "Hey what's up?", isCurrentUser: false),
    .init(id: 5, imageName: "batman", messageText: "Hey what's up?", isCurrentUser: true),
]
