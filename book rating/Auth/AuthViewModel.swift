//
//  AuthViewModel.swift
//  book rating
//
//  Created by Ejean Kuo on 8/25/25.
//
import SwiftUI

@Observable
final class AuthViewModel {
    var logInEmail = ""
    var logInPassword = ""
    
    var registerEmail = ""
    var registerPassword = ""
    var registerUsername = ""
    var registerDisplayName = ""
    var registerDOB = Date.now
    
    func logIn() {
        Task {
            do {
                try await AuthService.shared.signIn(email: logInEmail, password: logInPassword)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createAccount() {
        Task {
            do {
                try await AuthService.shared.registerNewUserWithEmail(email: registerEmail, password: registerPassword)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension EnvironmentValues {
    var authViewModel: AuthViewModel {
        get { self[AuthViewModelKey.self] }
        set { self[AuthViewModelKey.self] = newValue }
    }
}

private struct AuthViewModelKey: EnvironmentKey {
    static var defaultValue: AuthViewModel = AuthViewModel()
}
