//
//  AuthService.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//
import Foundation
import Supabase

enum Secrets {
    static let supabaseURL = "https://vpcolpqdncbgqryclssm.supabase.co"
    static let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZwY29scHFkbmNiZ3FyeWNsc3NtIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NjE0ODY0MywiZXhwIjoyMDcxNzI0NjQzfQ.o4vG0tPpQ-WKOtjrmnkdWS0nF1GboMYPZmC8adLxOFE"
    
}
@Observable
final class AuthService {
    
    static let shared = AuthService()
    
    var currentUser: RanklitUser?
    private let auth = SupabaseClient(supabaseURL: URL(string: Secrets.supabaseURL)!, supabaseKey: Secrets.supabaseKey).auth
    
    private init() {
        Task {
            do {
                let session = try await auth.session
                try await fetchCurrentUser(id: session.user.id, email: session.user.email ?? "")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCurrentUser(id: UUID, email: String) async throws {
        if let user = DatabaseService.shared.fetchUserFromStoredInfo(), id == user.id {
            currentUser = user
        } else {
            currentUser = try await DatabaseService.shared.fetchUserFromDatabase(email: email)
        }
    }
    
    func registerNewUserWithEmail(user: RanklitUser, password: String) async throws {
        let response = try await auth.signUp(email: user.email, password: password)
        var updatedUser = user
        updatedUser.id = response.session?.user.id
        
        try await DatabaseService.shared.createUserInDatabase(updatedUser)
        DatabaseService.shared.storeUserInfroOnDevice(user: updatedUser)
        currentUser = updatedUser
    }
    
    func signIn(email: String, password: String) async throws {
        let session = try await auth.signIn(email: email, password: password)
        if let user = DatabaseService.shared.fetchUserFromStoredInfo(), session.user.id == user.id {
            currentUser = user
        } else {
            currentUser = try await DatabaseService.shared.fetchUserFromDatabase(email: email)
        }
        
    }
    
    func signOut() async throws {
        try await auth.signOut()
        DatabaseService.shared.resetDeviceStorage()
        self.currentUser = nil
    }
}
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
enum Collection {
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
            .from(Collection.users)
            .insert(user, returning: .representation)
            .single()
            .execute()
            .value
        return user
    }
    
    func fetchUserFromDatabase(email: String) async throws -> RanklitUser {
        let users: [RanklitUser] = try await client
            .from(Collection.users)
            .select()
            .equals("email", value: email)
            .execute()
            .value
        
        guard let user = users.first else {
            throw URLError(.badURL) // TODO: currently is a default error, need to change
        }
        return user
    }
    
    // storing in user defaults
    func storeUserInfroOnDevice(user: RanklitUser) {
        UserDefaults.standard.setValue(user.id?.uuidString, forKey: "id")
        UserDefaults.standard.setValue(user.createdAt, forKey: "createdAt")
        UserDefaults.standard.setValue(user.username, forKey: "username")
        UserDefaults.standard.setValue(user.displayName, forKey: "displayName")
        UserDefaults.standard.setValue(user.email, forKey: "email")
        UserDefaults.standard.setValue(user.imageURL, forKey: "imageURL")
        UserDefaults.standard.setValue(user.dob, forKey: "dob")
        UserDefaults.standard.setValue(user.servers, forKey: "servers")
    }
    
    func fetchUserFromStoredInfo() -> RanklitUser? {
        if let idString = UserDefaults.standard.string(forKey: "id"),
            let id = UUID(uuidString: idString),
           let createdAt = UserDefaults.standard.object(forKey: "createdAt") as? Date,
           let username = UserDefaults.standard.string(forKey: "username"),
           let displayName = UserDefaults.standard.string(forKey: "displayName"),
           let email = UserDefaults.standard.string(forKey: "email"),
           let imageURL = UserDefaults.standard.string(forKey: "imageURL"),
           let dob = UserDefaults.standard.object(forKey: "dob") as? Date,
           let servers = UserDefaults.standard.array(forKey: "servers") as? [Int] {
            
            let user = RanklitUser(id: id, createdAt: createdAt, username: username, displayName: displayName, email: email, imageURL: imageURL, dob: dob, servers: servers)
            return user
        } else {
            return nil
        }
        
    }
    
    func resetDeviceStorage() {
        UserDefaults.standard.setValue(nil, forKey: "id")
        UserDefaults.standard.setValue(nil, forKey: "createdAt")
        UserDefaults.standard.setValue(nil, forKey: "username")
        UserDefaults.standard.setValue(nil, forKey: "displayName")
        UserDefaults.standard.setValue(nil, forKey: "email")
        UserDefaults.standard.setValue(nil, forKey: "imageURL")
        UserDefaults.standard.setValue(nil, forKey: "dob")
        UserDefaults.standard.setValue(nil, forKey: "servers")
    }
}

