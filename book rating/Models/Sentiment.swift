//
//  Sentiment.swift
//  book rating
//
//  Created by Ejean Kuo on 8/19/25.
//
//  user sentiments (liked, fine, disliked) of books
//  used in sorting algorithm

enum Sentiment: String, Codable, CaseIterable {
    case liked
    case fine
    case disliked
    
    var label: String {
        switch self {
        case .liked: return "I liked it"
        case .fine: return "It was fine"
        case .disliked: return "I didn't like it"
        }
    }
}

