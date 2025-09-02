//
//  DatabaseService.swift
//  book rating
//
//  Created by Ejean Kuo on 9/1/25.
//

import Foundation
import Supabase

enum Table {
    static let users = "users"
}
// database
@Observable
final class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let client = SupabaseClient(supabaseURL: URL(string: Secrets.supabaseURL)!, supabaseKey: Secrets.supabaseKey)
    
    private init() {}
    
    @discardableResult
    func createUserInDatabase(_ user: RanklitUser) async throws -> RanklitUser {
        let user: RanklitUser = try await client
            .from(Table.users)
            .insert(user, returning: .representation)
            .single()
            .execute()
            .value
        return user
    }
    
    func fetchUserFromDatabase(email: String) async throws -> RanklitUser {
        let user: RanklitUser = try await client
            .from(Table.users)
            .select()
            .equals("email", value: email)
            .single()
            .execute()
            .value
        
        return user
    }
    
}

