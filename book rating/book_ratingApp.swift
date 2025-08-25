//
//  book_ratingApp.swift
//  book rating
//
//  Created by Ejean Kuo on 8/3/25.
//
//  app entry point

import SwiftUI

@main
struct book_ratingApp: App {
    var body: some Scene {
        WindowGroup {
            if let user = AuthService.shared.currentUser {
                ContentView()
            } else {
                AuthView()
            }
        }
    }
}
