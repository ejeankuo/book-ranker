//
//  ContentView.swift
//  book rating
//
//  Created by Ejean Kuo on 8/3/25.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab: Tab = .Feed
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @Namespace var animation
    
    var body: some View {
        TabView(selection: $currentTab) {
            
            Text("Feed View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Feed)
            
            Text("Library View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Library)
            
            Text("Search View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Search)
            
            /*Text("Notifications View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Notifications)*/
            
            Text("Profile View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Profile)
        }
        .overlay(
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.rawValue){tab in
                    TabButton(tab: tab)
                }
                .padding(.vertical, 8)
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : (getSafeArea().bottom))
                .background(Color("kSecondary"))
            }
            ,
            alignment: .bottom
        ).ignoresSafeArea(.all, edges: .bottom)

    }
    
    func TabButton(tab: Tab) -> some View {
        GeometryReader{proxy in
            Button(action: {
                withAnimation(.spring()){
                    currentTab = tab
                }
            },label: {
                VStack(spacing: 4){
                    Image(systemName: tab.rawValue)
                        .resizable()
                        .foregroundColor(Color("kPrimary"))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity)
                        .fontWeight(currentTab == tab ? .bold: .regular)
                    Text(tab.Tabname)
                        .font(.footnote)
                        .fontWeight(currentTab == tab ? .bold : .regular)
                        .foregroundColor(Color("kPrimary"))
                }
            })
        }
        .frame(height: 55)
    }
}

#Preview {
    ContentView()
}

enum Tab: String, CaseIterable {
    case Feed = "newspaper"
    case Library = "books.vertical"
    case Search = "magnifyingglass.circle"
    //case Notifications = "bell"
    case Profile = "person.circle.fill"
    
    var Tabname: String {
        switch self {
        case .Feed:
            return "Feed"
        case .Library:
            return "Library"
        case .Search:
            return "Search"
        //case .Notifications:
            //return "Notifications"
        case .Profile:
            return "Profile"
        }
    }
}


extension View{
    func getSafeArea() -> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}

struct MaterialEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
