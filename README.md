# Ranklit :books:
Ranklit is an iOS app for logging and ranking books using **pairwise comparisons** rather than star ratings. 
Instead of having to assign their own scores, users can choose between two books at a time, and the app builds a personalized ranking from those decisions.

Traditional book apps rely on absolute ratings (e.g., 1–5 stars). Ranklit instead uses **relative preference**:

> Given two books, which do you prefer?

From enough comparisons, the app derives:
- A global ranking of a user’s books
- Top-N lists
  
This project is still in development.

## Current Status
### Implemented
- Email/password authentication with Supabase
- Persistent authenticated sessions
- Basic login and signup UI

### In Progress
- Book search and logging (via Open Library)
- Pairwise ranking flow

## Tech Stack
- **Platform:** iOS
- **UI:** SwiftUI
- **Backend/Auth:** Supabase
- **Book Data:** Open Library API
- **Language:** Swift

<img width="206" height="1622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-12-01 at 15 31 48" src="https://github.com/user-attachments/assets/95df36d9-27b0-4c83-b257-f299ae7ebca3" />

