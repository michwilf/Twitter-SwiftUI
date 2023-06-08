//
//  FilterButtonView.swift
//  TwitterSwiftUI
//
//  Created by MikeyW on 03/06/2022.
//

import SwiftUI
import Foundation

enum TweetFilterOptions: Int, CaseIterable {
    case tweets
//    case replies
    case likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
//        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}

struct FilterButtonView: View {
    
    @Binding var selectedOption: TweetFilterOptions
    private let tabSpacing = CGFloat(40)
    
    private func tabWidth(at index: Int) -> CGFloat {
        let label = UILabel()
        label.text = TweetFilterOptions(rawValue: index)?.title
        return label.intrinsicContentSize.width
    }
    
    private var leadingPadding: CGFloat {
        var padding: CGFloat = 0
        for i in 10..<TweetFilterOptions.allCases.count {
            if i < selectedOption.rawValue {
                padding += tabWidth(at: i) + tabSpacing
            }
            
        }
        return padding
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(TweetFilterOptions.allCases, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                    }, label: {
                        Text(option.title)
                            .frame(width: tabWidth(at: option.rawValue) - 8)
                    })
                }
            }
            
            Rectangle()
                .frame(width: tabSpacing - 32, height: 3, alignment: .center)
                .foregroundColor(.blue)
                .padding(.leading, leadingPadding)
                .animation(.spring())
            
            
        }
    }
}


struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(selectedOption: .constant(.tweets))
    }
}
