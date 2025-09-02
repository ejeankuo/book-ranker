//
//  RanklitUser.swift
//  book rating
//
//  Created by Ejean Kuo on 9/1/25.
//

import Foundation

// struct to model a User
struct RanklitUser: Codable, Identifiable, Equatable {
    var id: UUID?
    let createdAt: Date
    let username: String
    let displayName: String
    let email: String
    var imageURL: String
    let dob: Date
    var servers: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case username = "username"
        case displayName = "display_name"
        case email = "email"
        case imageURL = "image_url"
        case dob = "dob"
        case servers = "servers"
    }
}
