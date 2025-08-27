//
//  UserProfile.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//

import Foundation

struct UserProfile: Identifiable, Hashable, Codable {
    let id: UUID // auth.users.id
    var fullName: String
    var username: String
    var bio: String? // optional bio
    var pfpURL: URL? // optional profile photo ; AsyncImage to load
    
    // trackable metrics
    var followersCount: Int
    var followingCount: Int
    
    // "favorites" shelf
    // up to 4 book covers
    var favoriteCovers: [URL]?
}
