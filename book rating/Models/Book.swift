//
//  Book.swift
//  book rating
//
//  Created by Ejean Kuo on 8/4/25.
//

import Foundation

struct Book : Identifiable, Codable, Hashable {
    // book data
    var id = UUID()
    var title: String
    var author: String
    var coverImageURL: URL? // optional bc not all books will have images
    var workKey: String? // api call
    
    // book logging
    var sentiment: Sentiment? = nil
    var notes: String? = nil
    var favoriteQuotes: String? = nil
    var readDate: Date? = nil
    
    // ranking system
    var skill: Double = 0
    var wins: Int = 0
    var losses: Int = 0
    
    init(id: UUID = UUID(), title: String, author: String, coverURL: URL? = nil, workKey: String? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.coverImageURL = coverURL
        self.workKey = workKey
    }
}
