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
    static let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZwY29scHFkbmNiZ3FyeWNsc3NtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxNDg2NDMsImV4cCI6MjA3MTcyNDY0M30.fEJ_N6rOyTSsYYWAL6RpUQ91KXyxJpze2n_YY8SaT20"
    
}

@Observable
final class AuthService {
    
    static let shared = AuthService()
    
    var currentUser: User?

    private let auth = SupabaseClient(supabaseURL: URL(string: Secrets.supabaseURL)!, supabaseKey: Secrets.supabaseKey).auth
    
    private init() {
        Task {
            do {
                currentUser = try await auth.session.user
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func registerNewUserWithEmail(email: String, password: String) async throws {
        let response = try await auth.signUp(email: email, password: password)
        let user = response.user
        self.currentUser = user
    }
    
    func signIn(email: String, password: String) async throws {
        let session = try await auth.signIn(email: email, password: password)
        let user = session.user
        self.currentUser = user
    }
    
    func signOut() async throws {
        try await auth.signOut()
        self.currentUser = nil
    }
}
