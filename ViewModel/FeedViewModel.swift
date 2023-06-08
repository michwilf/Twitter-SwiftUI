//
//  FeedViewModel.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 07/06/2022.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    
    func fetchTweets() {
        COLLECTION_TWEETS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.tweets = documents.map({ Tweet(dictionary: $0.data()) })
        }
    }
}
